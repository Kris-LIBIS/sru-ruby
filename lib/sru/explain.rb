require 'sru/response'

module SRU
  class ExplainResponse < Response
    def version
      return xpath('.//zs:explainResponse/zs:version')
    end
  end
end
