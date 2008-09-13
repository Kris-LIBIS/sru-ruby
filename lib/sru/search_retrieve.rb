require 'sru/response'

module SRU
  
  # An iterator for search results which allows you to do stuff like:
  #
  #   client = SRU::Client.new 'http://sru.example.com'
  #   for record in client.search_retrieve('Mark Twain')
  #     puts record 
  #   end
  # 
  # The records returned are REXML::Document objects.
  
  class SearchResponse < Response
    include Enumerable

    def number_of_records
      return Integer(xpath(@doc, './/zs:numberOfRecords', @namespaces))
    end

    # Returns the contents of each recordData element in a 
    # SRU searchRetrieve response.
   
    def each
      obj = xpath_all(@doc, './/zs:recordData', @namespaces)
      for record_data in obj
        if obj.size > 0
          yield record_data
        end
      end
    end
  end
end
