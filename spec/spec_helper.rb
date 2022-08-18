# frozen_string_literal: true

require 'rspec'
require 'pry'

require './app/spreadsheet/sheet'

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }
