require './app/spreadsheet_table'

class Spreadsheet

  def initialize
    @spreadsheet_table = SpreadsheetTable.new
  end

  def get(cell)
    @spreadsheet_table.get(cell)
  end

  def put(cell, value)
    @spreadsheet_table.put(cell, value)
  end
end
