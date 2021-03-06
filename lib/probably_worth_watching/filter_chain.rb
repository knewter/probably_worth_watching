require 'forwardable'

module ProbablyWorthWatching
  class FilterChain
    extend Forwardable

    attr_reader :filter_list
    def_delegators :filter_list, :<<

    def initialize
      @filter_list = []
    end

    def execute(object)
      filter_list.map do |filter|
        object = filter.call(object) if object
      end
      object
    end
  end
end
