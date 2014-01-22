require 'helper'

describe MessageBird::HTTP::ResponseCode do

  let(:klass){ MessageBird::HTTP::ResponseCode}

  subject{ klass.new(:foo, 'bar') }

  describe '#to_sym' do
    it 'returns its symbol value' do
      subject.to_sym.must_equal :foo
    end
  end

  describe '#to_s' do
    it 'returns its string value' do
      subject.to_s.must_equal 'bar'
    end
  end

  describe '#==' do
    it 'compares Symbols with its symbol value' do
      mock.proxy(subject).to_sym.times(2)
      assert subject == :foo
      refute subject == :bar
    end

    it 'compares other objects with its string value' do
      mock.proxy(subject).to_s.times(2)
      assert subject == 'bar'
      refute subject == 'foo'
    end
  end

  describe '#self.decode' do
    it 'returns the matching ResponseCode' do
      result = klass.decode("01")
      assert result.is_a?(klass)
      assert result == :success
    end

    it 'raises an error when not found' do
      assert_raises(MessageBird::HTTP::ResponseCode::ResponseCodeNotFound){
        klass.decode("We are the Borg")
      }
    end
  end

end
