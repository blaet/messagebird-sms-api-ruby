require 'helper'

describe MessageBird::HTTP::Response do

  let(:mock_response){ OpenStruct.new(:body => 'repondre') }
  let(:klass){ MessageBird::HTTP::Response }

  describe '#initialize' do

    it 'decodes the given response' do
      mock(MessageBird::HTTP::ResponseCode).decode('repondre')
      klass.new(mock_response)
    end

    it 'stores the retrieved response code in a variable' do
      stub(MessageBird::HTTP::ResponseCode).decode{'test'}
      obj = klass.new(mock_response)
      obj.response_code.must_equal 'test'
    end

    describe 'invalid input' do
      let(:bad_response){ OpenStruct.new }

      it 'raises an ArgumentError if only argument does not respond to :body method' do
        assert_raises(ArgumentError){ klass.new(bad_response) }
      end
    end
  end

end
