module SRU
  module XPath
     
    # get all matching nodes
    def xpath_all(pdoc, path, namespace = '')
      case parser_type(pdoc)
      when 'libxml'
        if namespace!=""
           return pdoc.find(path, namespace).to_a if pdoc.find(path, namespace)
        else
 	   return pdoc.find(path).to_a if pdoc.find(path)
        end
      when 'rexml'
        if namespace!=""
           return REXML::XPath.match(pdoc, path, namespace)
        else
	   return REXML::XPath.match(pdoc, path);
        end
      end
      return []
    end

    # get first matching node
    def xpath_first(pdoc, path, namespace = '')
      elements = xpath_all(pdoc, path, namespace )
      return elements[0] if elements != nil
      return nil
    end

    # get text for first matching node
    def xpath(pdoc, path, namespace = '')
      el = xpath_first(pdoc, path, namespace)
      return unless el
      case parser_type(pdoc)
      when 'libxml'
        return el.content
      when 'rexml'
        return el.text 
      end
      return nil
    end

    # figure out an attribute
    def get_attribute(node, attr_name)
      case node.class.to_s
      when 'REXML::XML::Element'
        return node.attribute(attr_name)
      when 'LibXML::XML::Node'
        #There has been a method shift between 0.5 and 0.7
        if defined?(node.property) == nil
          return node.attributes[attr_name]
        else
          return node.property(attr_name)
        end
        #begin
        #        return node.attributes[attr_name]
        #rescue
         #   return node.property(attr_name)
        #end 
      end
      return nil
    end

    private 
   
    # figure out what sort of object we should do xpath on
    def parser_type(x)
      case x.class.to_s
      when 'LibXML::XML::Document'
        return 'libxml'
      when 'LibXML::XML::Node'
        return 'libxml'
      when 'LibXML::XML::Node::Set'
	return 'libxml'
      when 'REXML::Element'
        return 'rexml'
      when 'REXML::Document'
        return 'rexml'
      end
    end
  end
end
