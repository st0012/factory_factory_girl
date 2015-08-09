require 'rails/generators'
require "factory_girl_rails"
require 'generators/factory_girl/model/model_generator'

module Fakery
  module Generators
    class ModelGenerator < FactoryGirl::Generators::ModelGenerator
      SKIPED_COLUMN = %w{id created_at updated_at}

      def factory_attributes
        class_name.constantize.columns.map do |attribute|
          unless SKIPED_COLUMN.include? attribute.name
            "#{attribute.name} #{set_column(attribute)}"
          end
        end.compact.join("\n")
      end

      def set_column(attribute)
        match_results = rules.map do |rule|
          if attribute.name.match(rule[:rule])
            rule[:result]
          end
        end.compact

        if result = match_results.first
          result
        else
          default_value(attribute)
        end
      end

      def default_value(attribute)
        if attribute.default
          attribute.default
        else
          case attribute.type.to_s
          when "string"
            "\"MyString\""
          when "integer"
            1
          when "text"
            "\"MyText\""
          when "boolean"
            true
          when "datetime"
            "\"#{Time.now}\""
          else
            nil
          end
        end
      end

      def rules
        @rules ||= Fakery.configuration.rules
      end
    end
  end
end
