class Spreadsheet
  def get(cell)
    @value || ''
  end

  def put(cell, value)
    @value = value
  end
end
