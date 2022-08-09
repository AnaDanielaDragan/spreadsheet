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
end
