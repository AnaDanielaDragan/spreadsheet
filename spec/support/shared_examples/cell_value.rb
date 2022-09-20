# frozen_string_literal: true

RSpec.shared_examples 'a value result' do
  it 'returns the value' do
    expect(spreadsheet.get(cell)).to eq expected_value
  end
end

RSpec.shared_examples 'a parse error' do
  it 'returns a parse error' do
    expect { spreadsheet.get(cell) }.to raise_error(Parsers::FormulaParserError)
  end
end
