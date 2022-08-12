# frozen_string_literal: true

describe 'Spreadsheet' do
  context 'when creating a new spreadsheet' do
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

  context 'when writing numerics to cell' do
    subject(:put_value) { spreadsheet.put(cell, value) }

    let(:spreadsheet) { Spreadsheet.new }
    let(:cell) { 'A21' }

    context 'when given a string' do
      let(:value) { 'X99' }

      it 'returns value as string' do
        put_value

        expect(spreadsheet.get(cell)).to eq value
      end
    end

    context 'when given a mixed string and number value' do
      let(:value) { ' 99 X' }

      it 'returns value as string' do
        put_value

        expect(spreadsheet.get(cell)).to eq value
      end
    end

    context 'when given a number' do
      let(:value) { '14' }
      let(:expected_value) { 14 }

      it 'returns value as number' do
        put_value

        expect(spreadsheet.get(cell)).to eq expected_value
      end
    end

    context 'when given a mixed number and white space value' do
      let(:value) { ' 1234 ' }
      let(:expected_value) { 1234 }

      it 'returns value as number ignoring white spaces' do
        put_value

        expect(spreadsheet.get(cell)).to eq expected_value
      end
    end

    context 'when given a white space' do
      let(:value) { ' ' }

      it 'returns the white space' do
        put_value

        expect(spreadsheet.get(cell)).to eq value
      end
    end
  end

  context 'when adding multiple cells' do
    let(:spreadsheet) { Spreadsheet.new }

    before do
      spreadsheet.put('A1', 'First')
      spreadsheet.put('X27', 'Second')
      spreadsheet.put('Z99', 'Third')
    end

    it 'stores the values in the given cells' do
      expect(spreadsheet.get('A1')).to eq 'First'
      expect(spreadsheet.get('X27')).to eq 'Second'
      expect(spreadsheet.get('Z99')).to eq 'Third'
    end

    context 'when modifying a cell' do
      before do
        spreadsheet.put('A1', 'Fourth')
      end

      it 'updates the cell value' do
        expect(spreadsheet.get('A1')).to eq 'Fourth'
        expect(spreadsheet.get('X27')).to eq 'Second'
        expect(spreadsheet.get('Z99')).to eq 'Third'
      end
    end
  end

  context 'when requesting literal values' do
    subject(:put_value) { spreadsheet.put(cell, value) }

    let(:spreadsheet) { Spreadsheet.new }
    let(:cell) { 'A21' }

    context 'when value is a string' do
      let(:value) { 'Some string' }

      it 'returns a string' do
        put_value

        expect(spreadsheet.get_literal(cell)).to eq value
      end
    end

    context 'when value is numeric' do
      let(:value) { '14' }

      it 'returns a string' do
        put_value

        expect(spreadsheet.get_literal(cell)).to eq value
      end
    end

    context 'when value is numeric with white spaces' do
      let(:value) { ' 1234 ' }

      it 'returns a string' do
        put_value

        expect(spreadsheet.get_literal(cell)).to eq value
      end
    end

    context 'when value is a formula' do
      let(:value) { '=7' }

      it 'returns a string' do
        put_value

        expect(spreadsheet.get_literal(cell)).to eq value
      end
    end
  end
end
