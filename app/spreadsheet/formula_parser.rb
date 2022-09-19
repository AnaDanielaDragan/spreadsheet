# frozen_string_literal: true

module Spreadsheet
  class FormulaParser

    class << self
      def get_result(value)
        @current_value = value[1..]

        BasicMathParser.evaluate(@current_value)
      end
    end
  end
end
