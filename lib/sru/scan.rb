require 'sru/response'

module SRU

  # A wrapper for the scan response from a SRU server.
  class ScanResponse < Response
    include Enumerable

    def each
      for term_node in xpath_all(@doc, './/zs:term', @namespaces)
        yield Term.new(term_node) 
      end
    end
  end

end
