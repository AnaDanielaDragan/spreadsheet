# frozen_string_literal: true

require './app/spreadsheet/table'

module Spreadsheet
  class Sheet
    def initialize
      @spreadsheet_table = Spreadsheet::Table.new
    end

    def get(cell)
      @spreadsheet_table.get(cell)
    end

    def get_literal(cell)
      @spreadsheet_table.get_literal(cell)
    end

    def put(cell, value)
      @spreadsheet_table.put(cell, value)
    end
  end
end
