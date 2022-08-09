class Spreadsheet

  TABLE_LENGTH = 26
  TABLE_HEIGHT = 100

  def initialize
    @table = Array.new(TABLE_LENGTH){ Array.new(TABLE_HEIGHT) { '' } }
  end

  def get(cell)
    read_cell(parse_cell_row(cell), parse_cell_column(cell))
  end

  def put(cell, value)
    write_cell(parse_cell_row(cell), parse_cell_column(cell), value)
  end

  private


  def parse_cell_row(cell)
    Array('A' .. 'Z').find_index(cell[0])
  end

  def parse_cell_column(cell)
    cell[1 ..].to_i
  end

  def write_cell(row, column, value)
    @table[row][column] = value
  end

  def read_cell(row, column)
    @table[row][column]
  end
end
