require 'sru/response'

module SRU
  class ExplainResponse < Response
    def version
      version = xpath('.//zs:explainResponse/zs:version')
      return version if version

      # also look here 
      info = xpath_first('.//serverInfo')
      return info.attributes['version'] if info
      
      return nil
    end
  end
end
