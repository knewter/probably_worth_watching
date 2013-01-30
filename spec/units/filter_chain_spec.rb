require_relative '../spec_helper'

describe FilterChain do
  subject{ FilterChain.new }
  it 'can be instantiated' do
    subject.must_be_instance_of FilterChain
  end
end
