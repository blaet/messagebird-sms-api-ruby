require 'helper'

describe MessageBird::HTTP::LocalConnection do

  let(:klass){ MessageBird::HTTP::LocalConnection }

  subject{ klass.new("host", "port") }

  describe '#initialize' do
    it 'takes two arguments' do
      klass.new("host", "port")
    end
  end

  describe '#request' do
    it 'responds to #request' do
      assert subject.respond_to?(:request)
    end

    it 'takes one argument' do
      subject.request("")
    end

    it 'always returns an object that responds with the :success response body' do
      subject.request("").body.must_equal "01"
    end
  end

end
