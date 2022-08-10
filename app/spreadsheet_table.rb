require './app/table'

class SpreadsheetTable
  TABLE_LENGTH = 26
  TABLE_HEIGHT = 100

  def initialize
    @table = Table.new(TABLE_LENGTH, TABLE_HEIGHT)
  end

  def get(cell)
    table_value = @table.read_cell(parse_cell_row(cell), parse_cell_column(cell))
    parse_value(table_value)
  end

  def get_literal(cell)
    @table.read_cell(parse_cell_row(cell), parse_cell_column(cell))
  end

  def put(cell, value)
    @table.write_cell(parse_cell_row(cell), parse_cell_column(cell), value)
  end

  private

  def parse_value(value)
    return value unless is_number?(value)

    value.strip.to_i
  end

  def is_number?(value)
    value.strip.match?(/\A-?\d+\Z/)
  end

  def parse_cell_row(cell)
    Array('A' .. 'Z').find_index(cell[0])
  end

  def parse_cell_column(cell)
    cell[1 ..].to_i
  end
end
