class Table

  def initialize(length, height)
    @table = Array.new(length){ Array.new(height) { '' } }
  end

  def write_cell(row, column, value)
    @table[row][column] = value
  end

  def read_cell(row, column)
    @table[row][column]
  end
end
