module ClassyEnum
  class SemanticFormBuilder < Formtastic::SemanticFormBuilder # :nodoc: all
    def enum_select_input(method, options)
      enum_class = object.send(method)

      if enum_class.nil?
        enum_class = (options[:enum_class] || method).to_s.classify.constantize rescue Error.invalid_classy_enum_object(method)
        options[:collection] = enum_class.select_options
      else
        Error.invalid_classy_enum_object(method) unless enum_class.is_a? ClassyEnum::Base
        options[:collection] = enum_class.class.superclass.select_options
        options[:selected] = enum_class.to_s
      end

      options[:include_blank] = false

      select_input(method, options)
    end
  end

  module Error # :nodoc: all
    def self.invalid_classy_enum_object(method)
      raise "#{method} is not a ClassyEnum object. Make sure you've added 'classy_enum_attr :#{method}' to your model"
    end
  end
end
