require 'rexml/xpath'

module SRU

  # base class for all SRU responses
  class Response
    attr_reader :doc

    # namespaces for use in xpath queries
    @@namespaces = {'zs' => 'http://www.loc.gov/zing/srw/'}

    def initialize(doc)
      @doc = doc
    end

    protected

    # helper for doing xpath
    def xpath_all(path)
      return REXML::XPath.match(@doc, path, @@namespaces)
    end

    def xpath_first(path)
      elements = xpath_all(path)
      return elements[0] if elements != nil
      return nil
    end

    def xpath(path)
      e = xpath_first(path)
      return e.text if e != nil
      return nil
    end
  end

end
