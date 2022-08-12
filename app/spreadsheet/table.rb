# frozen_string_literal: true

require './app/table'
require './app/spreadsheet/formula_parser'

module Spreadsheet
  class Table
    TABLE_LENGTH = 26
    TABLE_HEIGHT = 100

    def initialize
      @table = ::Table.new(TABLE_LENGTH, TABLE_HEIGHT)
    end

    def get(cell)
      table_value = get_literal(cell)

      if number?(table_value)
        table_value.strip.to_i
      elsif formula?(table_value)
        Spreadsheet::FormulaParser.get_result(table_value)
      else
        table_value
      end
    end

    def get_literal(cell)
      @table.read_cell(parse_cell_row(cell), parse_cell_column(cell))
    end

    def put(cell, value)
      @table.write_cell(parse_cell_row(cell), parse_cell_column(cell), value)
    end

    private

    def formula?(value)
      value[0] == '='
    end

    def number?(value)
      value.strip.match?(/\A-?\d+\Z/)
    end

    def parse_cell_row(cell)
      Array('A'..'Z').find_index(cell[0])
    end

    def parse_cell_column(cell)
      cell[1..].to_i
    end
  end
end
