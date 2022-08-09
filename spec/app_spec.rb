require './app/app'
require 'spreadsheet'
require 'pry'

describe App do
  describe '.run' do
    context 'when creating a new sheet' do
      let!(:spreadsheet) { Spreadsheet::Workbook.new }
      let!(:sheet) { spreadsheet.create_worksheet }

      it 'has no populated cells by default' do
        expect(sheet.row_count).to eq 0
        expect(sheet.column_count).to eq 0
      end
    end
  end
end