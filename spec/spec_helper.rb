require 'bundler/setup'

require 'minitest/spec'
require 'turn/autorun'
require 'mocha/setup'
require 'pry'

Turn.config.format = :outline

require_relative '../lib/probably_worth_watching'

include ProbablyWorthWatching
