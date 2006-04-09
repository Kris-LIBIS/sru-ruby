require 'uri'
require 'cgi'
require 'net/http'
require 'rexml/document'
require 'sru/explain'

module SRU

  # A client for issuing requests to a particular SRU server.
  # SRU is a RESTlike information retrieval protocol detailed at
  # http://www.loc.gov/standards/sru/
  
  class Client

    # creates a client object which will automatically perform an
    # explain request to determine the version to be used in 
    # subsequent requests.
    
    def initialize(base)
      @server = URI.parse base

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
      return ExplainResponse.new(doc)
    end


    # Send a searchRetrieve request to the SRU server and return
    # a SRU::SearchResponse object. The first argument is the required 
    # query option. Any remaining searchRetrieve options can be passed 
    # as an optional second argument. 
    # 
    #   client = SRU::Client.new 'http://example.com/sru'
    #   response = client.search_retrieve('mark twain', maximumRecords => 1)
    
    def search_retrieve(query, options={})
      options['query'] = query
      options['operation'] = 'searchRetrieve'
      doc = get_doc(options)
      return SearchResponse.new(doc)
    end


    def scan
    end

    private
    
    def get_doc(hash)
      # all requests get a version
      hash['version'] = @version

      # don't want to monkey with the original
      uri = @server.clone

      # no ruby class for building a query string!?!?
      parts = hash.entries.map { |e| 
        name, value = e[0], String(e[1])
        "#{name}=#{CGI.escape(value)}"
      }

      uri.query = parts.join('&')
      xml = Net::HTTP.get(uri)

      return REXML::Document.new(xml)
    end
  end
end
