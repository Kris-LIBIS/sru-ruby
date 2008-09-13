require 'sru/response'

module SRU
  class ExplainResponse < Response
    def to_s
      return "host=#{host} port=#{port} database=#{database} version=#{version}"
    end

    def host
      return xpath(@doc,'.//ns0:serverInfo/ns0:host', @namespaces )
    end

    def port
      port = xpath(@doc, './/ns0:serverInfo/ns0:port', @namespaces)
      return nil if not port
      return Integer(port)
    end

    def database
      return xpath(@doc, './/ns0:serverInfo/ns0:database', @namespaces)
    end
    
    def number_of_records
      return xpath(@doc, './/ns0:configInfo/ns0:numberOfRecords', @namespaces)
    end

    def version
      version = xpath(@doc, './/zs:version', @namespaces)
      return version if version

      # also look here 
      info = xpath(@doc, './/ns0:serverInfo', @namespaces)
      #return info.attributes['version'] if info
      return get_attribute(info, "version") if info
      return nil
    end
  end
end
