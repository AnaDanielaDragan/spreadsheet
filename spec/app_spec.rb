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

    context 'when storing text cells' do
      let!(:spreadsheet) { Spreadsheet::Workbook.new }
      let!(:sheet) { spreadsheet.create_worksheet }

      it 'saves the text cell' do
        binding.pry
        cell_text = 'A string'
        expect{ sheet.row(0).push cell_text }.to change { sheet.cell(0,0) }.from(nil).to(cell_text)

        cell_text2 = 'A different string'
        expect{ sheet.row(0).replace [cell_text2] }.to change { sheet.cell(0,0) }.from(cell_text).to(cell_text2)

        cell_text3 = ''
        expect{ sheet.row(0).replace [cell_text3] }.to change { sheet.cell(0,0) }.from(cell_text2).to(cell_text3)
      end
    end
  end
end