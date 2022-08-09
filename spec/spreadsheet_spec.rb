require 'rspec'
require './app/spreadsheet'

describe 'Spreadsheet' do
  before do
    # Do nothing
  end

  after do
    # Do nothing
  end

  context 'when creating a new sheet' do
    let(:spreadsheet) { Spreadsheet.new }

    it 'has empty cells by default' do
      expect(spreadsheet.get('A1')).to eq ''
      expect(spreadsheet.get('ZX347')).to eq ''
    end
  end

  context 'when writing text to cell' do
    let(:spreadsheet) { Spreadsheet.new }
    let(:cell) { 'A21' }

    it 'stores the text' do
      spreadsheet.put(cell, 'A string')
      expect(spreadsheet.get(cell)).to eq 'A string'

      spreadsheet.put(cell, 'A different string')
      expect(spreadsheet.get(cell)).to eq 'A different string'

      spreadsheet.put(cell, '')
      expect(spreadsheet.get(cell)).to eq ''
    end
  end
end
