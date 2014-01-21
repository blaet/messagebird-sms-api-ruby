require 'helper'

describe MessageBird::SMS do
  subject{ MessageBird::SMS }

  describe '#new' do
    it 'checks which module to use for sending' do
      mock(subject).klass_for(:https).once{ stub(Object.new).new }
      subject.new(:one,:two,:three,{:module => :https})
    end

    it 'returns a new SMS object of the appropriate module' do
      subject.new(1,2,3,{:module => :http}).class.must_equal MessageBird::HTTP::SMS
    end
  end

  describe '#klass_for' do
    it 'takes a string' do
      subject.send(:klass_for, 'http')
    end

    it 'takes a symbol' do
      subject.send(:klass_for, :http)
    end

    it 'returns the appropriate SMS class for the given module' do
      subject.send(:klass_for, 'http').must_equal MessageBird::HTTP::SMS
    end
  end

end
