module SRU

  # a class for representing a term in the response from a sru server
  class Term < Response
    attr_accessor :value, :number_of_records, :display_term, :where_in_list, 
      :extra_term_data

    def initialize(element)
      super element
      @value = xpath('value')
      @number_of_records = xpath('numberOfRecords')
      @display_term = xpath('displayTerm')
      @where_in_list = xpath('whereInList')
      @extra_term_data = xpath_first('extraTermData')
    end
  end
end
