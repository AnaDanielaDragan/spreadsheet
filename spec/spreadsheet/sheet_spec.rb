# frozen_string_literal: true

describe 'Sheet' do
  describe '.put' do
    let(:spreadsheet) { Spreadsheet::Sheet.new }

    context 'when adding a cell' do
      let(:cell) { 'A21' }
      let(:value) { 'A string' }

      before do
        spreadsheet.put(cell, value)
      end

      it 'stores the value' do
        expect(spreadsheet.get(cell)).to eq value
      end

      context 'when modifying the cell value' do
        let(:value) { 'A different string' }

        it 'stores the new value' do
          spreadsheet.put(cell, value)
          expect(spreadsheet.get(cell)).to eq value

          spreadsheet.put(cell, '')
          expect(spreadsheet.get(cell)).to eq ''
        end
      end
    end

    context 'when adding multiple cells' do
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
        it 'updates the cell value' do
          spreadsheet.put('A1', 'Fourth')

          expect(spreadsheet.get('A1')).to eq 'Fourth'
          expect(spreadsheet.get('X27')).to eq 'Second'
          expect(spreadsheet.get('Z99')).to eq 'Third'
        end
      end
    end
  end

  describe '.get_literal' do
    let(:spreadsheet) { Spreadsheet::Sheet.new }
    let(:cell) { 'A21' }

    before do
      spreadsheet.put(cell, value)
    end

    context 'when value is a string' do
      let(:value) { 'Some string' }

      it 'returns a string' do
        expect(spreadsheet.get_literal(cell)).to eq value
      end
    end

    context 'when value is numeric' do
      let(:value) { '14' }

      it 'returns a string' do
        expect(spreadsheet.get_literal(cell)).to eq value
      end
    end

    context 'when value is numeric with white spaces' do
      let(:value) { ' 1234 ' }

      it 'returns a string' do
        expect(spreadsheet.get_literal(cell)).to eq value
      end
    end

    context 'when value is a formula' do
      let(:value) { '=7' }

      it 'returns a string' do
        expect(spreadsheet.get_literal(cell)).to eq value
      end
    end
  end

  describe '.get' do
    let(:spreadsheet) { Spreadsheet::Sheet.new }

    context 'when cell value is text' do
      let(:cell) { 'A21' }

      before do
        spreadsheet.put(cell, value)
      end

      context 'when value is a string' do
        let(:value) { 'A string' }

        it 'returns a string' do
          expect(spreadsheet.get(cell)).to eq value
        end
      end

      context 'when value is a white space' do
        let(:value) { ' ' }

        it 'returns the white space' do
          expect(spreadsheet.get(cell)).to eq value
        end
      end

      context 'when value is an empty string' do
        let(:value) { '' }

        it 'returns an empty string' do
          expect(spreadsheet.get(cell)).to eq value
        end
      end
    end

    context 'when cell value contains numbers' do
      let(:cell) { 'A21' }

      before do
        spreadsheet.put(cell, value)
      end

      context 'when value is a string' do
        let(:value) { 'X99' }

        it 'returns value as string' do
          expect(spreadsheet.get(cell)).to eq value
        end
      end

      context 'when value is a mixed string with numbers' do
        let(:value) { ' 99 X' }

        it 'returns value as string' do
          expect(spreadsheet.get(cell)).to eq value
        end
      end

      context 'when value is a number' do
        let(:value) { '14' }
        let(:expected_value) { 14 }

        it_behaves_like 'a value result'
      end

      context 'when value is a mixed number with white spaces' do
        let(:value) { ' 1234 ' }
        let(:expected_value) { 1234 }

        it_behaves_like 'a value result'
      end
    end

    context 'when cell value is a formula' do
      before do
        spreadsheet.put(cell, value)
      end

      context 'when formula is invalid' do
        let(:cell) { 'B1' }
        let(:value) { ' =7' }

        it 'returns the string value' do
          expect(spreadsheet.get(cell)).to eq(value), 'Not a formula'
          expect(spreadsheet.get_literal(cell)).to eq value
        end
      end

      context 'when constant' do
        let(:cell) { 'A1' }
        let(:value) { '=7' }
        let(:expected_value) { 7 }

        it_behaves_like 'a value result'

        context 'when requesting the literal value' do
          let(:expected_value) { '=7' }

          it 'returns value as string' do
            expect(spreadsheet.get_literal(cell)).to eq expected_value
          end
        end
      end
    end
  end

  context 'when creating a new spreadsheet' do
    let(:spreadsheet) { Spreadsheet::Sheet.new }
    let(:empty_value) { '' }

    it 'has empty cells by default' do
      expect(spreadsheet.get('A1')).to eq empty_value
      expect(spreadsheet.get('ZX347')).to eq empty_value
    end
  end

  context 'when using formulas' do
    let(:spreadsheet) { Spreadsheet::Sheet.new }
    let(:cell) { 'A1' }

    before do
      spreadsheet.put(cell, value)
    end

    context 'with parentheses' do
      let(:value) { '=(7)' }
      let(:expected_value) { '7' }

      it_behaves_like 'a value result'
    end

    context 'with deep parentheses' do
      let(:value) { '=((((10))))' }
      let(:expected_value) { '10' }

      it_behaves_like 'a value result'
    end

    context 'with multiplication' do
      let(:value) { '=2*3*4' }
      let(:expected_value) { 24 }

      it_behaves_like 'a value result'
    end

    context 'with addition' do
      let(:value) { '=71+2+3' }
      let(:expected_value) { 76 }

      it_behaves_like 'a value result'
    end

    context 'with subtraction' do
      let(:value) { '=21-5-4' }
      let(:expected_value) { 12 }

      it_behaves_like 'a value result'

      context 'when result is a negative number' do
        let(:value) { '=7-21' }
        let(:expected_value) { -14 }

        it_behaves_like 'a value result'
      end
    end
  end
end
