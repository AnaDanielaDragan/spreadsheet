require './app/spreadsheet_table'

class Spreadsheet

  def initialize
    @spreadsheet_table = SpreadsheetTable.new
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
