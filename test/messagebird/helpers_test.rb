require 'helper'

class MockObject
  include MessageBird::Helpers
end

describe MessageBird::Helpers do

  subject{ MockObject.new }

  describe '#config' do
    it 'returns the appropriate config object' do
      subject.config.must_equal MessageBird::Config
    end
  end

  describe '#contantize' do
    it 'converts a string into its corresponding constant' do
      subject.constantize('String').must_equal String
      subject.constantize('Integer').must_equal Integer
      subject.constantize('MessageBird::Helpers').must_equal MessageBird::Helpers
    end

    it 'raises a NameError when class is not found' do
      assert_raises(NameError) { subject.constantize('NonExistentClass') }
    end

    it 'raises a NameError when string not a valid class name' do
      assert_raises(NameError) { subject.constantize(':::String') }
    end
  end
end
