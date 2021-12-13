# frozen_string_literal: true

require 'rubocop'

require_relative 'rubocop/sorted'
require_relative 'rubocop/sorted/version'
require_relative 'rubocop/sorted/inject'

RuboCop::Sorted::Inject.defaults!

require_relative 'rubocop/cop/sorted_cops'
