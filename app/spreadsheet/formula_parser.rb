# frozen_string_literal: true

module Spreadsheet
  class FormulaParser
    INNER_PARENTHESES_REGEX = /.*\((.*?)\)/.freeze
    NUMERIC_REGEX = /\A-?\d+\Z/.freeze

    MATH_OPERATIONS = %w[+ *].freeze

    class << self
      def get_result(value)
        @current_value = value[1..]

        if constant?
          @current_value.strip.to_i
        elsif math_operation?
          resolve_math_operation
        elsif parentheses?
          @current_value.slice(INNER_PARENTHESES_REGEX, 1)
        else
          @current_value
        end
      end

      private

      def constant?
        @current_value.strip.match?(NUMERIC_REGEX)
      end

      def parentheses?
        @current_value.include?('(') and @current_value.include?(')')
      end

      def math_operation?
        MATH_OPERATIONS.any? { |math_operation| @current_value.include? math_operation }
      end

      def resolve_math_operation
        if sum?
          @current_value.split('+').map(&:to_i).inject(:+)
        elsif multiplication?
          @current_value.split('*').map(&:to_i).inject(:*)
        end
      end

      def sum?
        @current_value.include?('+')
      end

      def multiplication?
        @current_value.include?('*')
      end
    end
  end
end
