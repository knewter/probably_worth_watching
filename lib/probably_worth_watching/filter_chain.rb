require 'forwardable'

module ProbablyWorthWatching
  class FilterChain
    extend Forwardable

    attr_reader :filter_list
    def_delegators :filter_list, :<<

    def initialize
      @filter_list = []
    end
  end
end
