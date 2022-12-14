# frozen_string_literal: true

require 'rspec'
require 'pry'
require 'basic_math_parser'

require './app/spreadsheet/sheet'
require './app/parsers/formula_parser'

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }
