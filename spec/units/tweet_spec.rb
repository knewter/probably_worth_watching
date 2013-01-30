require_relative '../spec_helper'

describe Tweet do
  subject { Tweet.new }

  describe 'attributes' do
    it 'has content' do
      subject.content = 'foo'
      subject.content.must_equal 'foo'
    end

    it 'has an author' do
      subject.author = 'knewter'
      subject.author.must_equal 'knewter'
    end
  end
end
