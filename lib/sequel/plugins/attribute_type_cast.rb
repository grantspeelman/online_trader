# frozen_string_literal: true

module Sequel
  module Plugins
    module AttributeTypeCast
      module ClassMethods
        def attribute_type_cast(column_name, klass)
          define_method(:"#{column_name}=") do |val|
            super(klass.cast(val))
          end

          define_method(column_name) do
            klass.cast(super())
          end
        end
      end
    end
  end
end
