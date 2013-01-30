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
  describe 'execute' do
    before do
      @mock_tweet = mock 'tweet'
      @mock_filter = mock 'filter'
    end

    it 'executes the chain on a given object' do
      @mock_filter.expects(:call).with(@mock_tweet).returns(@mock_tweet)

      subject << @mock_filter
      subject.execute(@mock_tweet)
    end

    it 'sends the output of one filter to the input of the next' do
      @second_filter = mock 'second filter'
      @modified_tweet = mock 'modified tweet'

      @mock_filter.stubs(:call).returns(@modified_tweet)
      @second_filter.expects(:call).with(@modified_tweet)

      subject << @mock_filter
      subject << @second_filter
      subject.execute(@mock_tweet)
    end

    it 'returns the last value returned by any filter' do
      @mock_filter.stubs(:call).returns(1)

      subject << @mock_filter
      subject.execute(@mock_tweet).must_equal 1
    end

    it 'halts the filter chain if any filter returns something falsey' do
      @second_filter = mock 'second_filter'

      @mock_filter.stubs(:call).returns(false)
      @second_filter.expects(:call).never

      subject << @mock_filter
      subject << @second_filter
      subject.execute(@mock_tweet)
    end
  end
end
