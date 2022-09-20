# frozen_string_literal: true

require './app/errors/parsers/formula_parser_error'

module Parsers
  class FormulaParser
    class << self
      def get_result(value)
        @current_value = value[1..]

        BasicMathParser.evaluate(@current_value)
      rescue BasicMathParser::ParseError
        raise Parsers::FormulaParserError
      end
    end
  end
end
