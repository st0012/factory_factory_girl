require 'rails/generators'
require "factory_girl_rails"
require 'generators/factory_girl/model/model_generator'

module FactoryFactoryGirl
  module Generators
    class ModelGenerator < FactoryGirl::Generators::ModelGenerator
      SKIPED_COLUMN = %w{id created_at updated_at}

      private

      def factory_attributes
        class_name.constantize.columns.map do |attribute|
          unless SKIPED_COLUMN.include? attribute.name
            "#{attribute.name} #{set_column(attribute)}"
          end
        end.compact.join("\n    ")
      end

      def set_column(attribute)
        applied_rule = get_match_results(rules, attribute).first
        return default_value(attribute) unless applied_rule
        return "{ #{applied_rule[:function]} }" unless applied_rule[:value]
        transfer_value_type(applied_rule[:value], attribute.type.to_s)
      end

      def get_match_results(rules, attribute)
        rules.map { |rule| rule if is_matched_rule?(rule, attribute) }.compact
      end

      def is_matched_rule?(rule, attribute)
        return true if attribute.name.match(rule[:rule])
        false
      end

      def transfer_value_type(value, type)
        case type
        when "string" || "text"
          "\"#{value}\""
        when "integer"
          value.to_i
        else
          value
        end
      end

      def default_value(attribute)
        return attribute.default if attribute.default
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

      def rules
        return @rules if @rules
        FactoryFactoryGirl.configuration.rules
      end
    end
  end
end
