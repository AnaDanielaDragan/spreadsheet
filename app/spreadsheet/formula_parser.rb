# frozen_string_literal: true

module Spreadsheet
  class FormulaParser

    INNER_PARENTHESES_REGEX = /.*\((.*?)\)/.freeze
    NUMERIC_REGEX = /\A-?\d+\Z/.freeze

    class << self
      def get_result(value)
        @current_value = value[1..]

        if constant?
          @current_value.strip
        elsif parentheses?
          @current_value.slice(INNER_PARENTHESES_REGEX, 1)
        end
      end

      private

      def parentheses?
        @current_value.include?('(') and @current_value.include?(')')
      end

      def constant?
        @current_value.strip.match?(NUMERIC_REGEX)
      end
    end
  end
end
