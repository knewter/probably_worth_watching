require_relative '../spec_helper'

describe FilterChain do
  subject{ FilterChain.new }
  it 'can be instantiated' do
    subject.must_be_instance_of FilterChain
  end
  describe 'filter_list' do
    it 'starts off empty' do
      subject.filter_list.must_equal []
    end
    it 'can have new filters shoveled into it' do
      mock_filter = mock 'filter'
      subject << mock_filter
      subject.filter_list.must_include mock_filter
    end
  end
end
