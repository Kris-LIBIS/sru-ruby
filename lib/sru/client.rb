# frozen_string_literal: true

require 'uri'
require 'cgi'
require 'net/http'

module SRU

  # A client for issuing requests to a particular SRU server.
  # SRU is a RESTlike information retrieval protocol detailed at
  # http://www.loc.gov/standards/sru/
  #
  #  require 'sru'
  #
  #  client = SRU::Client.new 'http://sru.example.com'
  #
  #  # fetch a SRU::ExplainResponse object from the server
  #  explain = client.explain
  #
  #  # issue a search and get back a SRU::SearchRetrieveResponse object 
  #  # which serves as an iterator 
  #  records = client.search_retrieve 'rosetta stone', :maximumRecords => 5
  #  records.each {|record| puts record}
  #
  #  # issue a scan request and print out each term
  #  client.scan('king tut', :maximumTerms => 12).each {|term| puts term}
  
  class Client

    DEFAULT_SRU_VERSION = '1.2'

    attr_accessor :version
    # creates a client object which will automatically perform an
    # explain request to determine the version to be used in 
    # subsequent requests.
    
    def initialize(base,options={})
      @server = URI.parse base
      @parser = options.fetch(:parser, 'rexml')
      case @parser
      when 'libxml'
        begin
          require 'rubygems'
          require 'libxml'
        rescue
          raise SRU::Exception, "unknown parser: #{@parser}", caller 
        end
      when 'rexml'
        require 'rexml/document'
        require 'rexml/xpath'
      else
        raise SRU::Exception, "unknown parser: #{@parser}", caller
      end
        
      # stash this away for future requests
      @version = self.explain.version
    end


    # Send an explain request to the SRU server and return a 
    # SRU::ExplainResponse object.
    #
    # client = SRU::Client.new 'http://sru.example.com'
    # explain = client.explain
    
    def explain
      doc = get_doc(:operation => 'explain')
      return ExplainResponse.new(doc, @parser)
    end


    # Send a searchRetrieve request to the SRU server and return
    # a SRU::SearchResponse object. The first argument is the required 
    # query option. Any remaining searchRetrieve options can be passed 
    # as an optional second argument. 
    # 
    #   client = SRU::Client.new 'http://example.com/sru'
    #   response = client.search_retrieve 'mark twain', maximumRecords => 1
    
    def search_retrieve(query, options={})
      options[:query] = query
      options[:operation] = 'searchRetrieve'
      options[:maximumRecords] = 10 unless options.has_key? :maximumRecords
      options[:recordSchema] = 'dc' unless options.has_key? :recordSchema
      doc = get_doc(options)
      return SearchResponse.new(doc, @parser)
    end


    # Send a scan request to the SRU server and return a SRU::ScanResponse
    # object. You must supply the first parameter which is the searchClause.
    # Other SRU options can be sent in a hash as the seond argument.
    #
    #   scan_response = client.scan 'title', :maximumTerms => 5
   
    def scan(clause, options={})
      options[:scanClause] = clause
      options[:operation] = 'scan'
      options[:maximumTerms] = 5 unless options.has_key? :maximumTerms
      doc = get_doc(options)
      return ScanResponse.new(doc, @parser)
    end

    private

    # helper to fetch xml responses from the sru server
    # given a set of options
   
    def get_doc(hash)
      # all requests get a version
      if ! hash.has_key? :version
        if defined? @version
          hash[:version] = @version # value obtained from Explain operation
        else
          hash[:version] = DEFAULT_SRU_VERSION
        end
      end

      # don't want to monkey with the original
      uri = @server.clone

      # no ruby class for building a query string!?!?
      # probably just wasn't looking in the right place
      parts = hash.entries.map { |entry| 
        "#{entry[0]}=#{CGI.escape(entry[1].to_s)}"
      }
      uri.query = parts.join('&')
      # fetch the xml and build/return a document object from it
      begin
        res = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') {|http|
          req = Net::HTTP::Get.new(uri.request_uri, { "Accept" => "text/xml, application/xml"})
          if uri.user && uri.password
            req.basic_auth uri.user, uri.password
          end
          http.request(req)
        }
        
        xml = res.body
         # load appropriate parser
        case @parser
          when 'libxml'
            xmlObj = LibXML::XML::Parser.string(xml)
	          # not sure why but the explain namespace does bad things to 
            # libxml
            #xml = xml.gsub(' xmlns="http://explain.z3950.org/dtd/2.0/"', '')            
            return xmlObj.parse
          when 'rexml'
            return REXML::Document.new(xml)
        end
      rescue Exception => e
        print e.backtrace.join("\n")
        raise SRU::Exception, "exception during SRU operation", caller
      end
    end
  end
end
