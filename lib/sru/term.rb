module SRU

  # a class for representing a term in the response from a sru server
  class Term < Response
    attr_accessor :value, :number_of_records, :display_term, :where_in_list, 
      :extra_term_data

    def initialize(element)
      super element
      @value = xpath(@doc, 'value')
      @number_of_records = xpath(@doc, 'numberOfRecords')
      @display_term = xpath(@doc, 'displayTerm')
      @where_in_list = xpath(@doc, 'whereInList')
      @extra_term_data = xpath_first(@doc, 'extraTermData')
    end
  end
end
