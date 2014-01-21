require 'helper'

describe MessageBird::SMS do
  subject{ MessageBird::SMS }

  describe '#deliver' do
    let(:sms){ Object.new }

    it 'creates a new SMS object' do
      stub(sms).deliver.with_any_args
      mock(subject).new.with_any_args{sms}
      subject.deliver(1,2,'msg')
    end

    it 'commands the SMS object to deliver itself' do
      mock(sms).deliver.with_any_args
      stub(subject).new.with_any_args{sms}
      sms.deliver(1,2,'msg')
    end
  end

  describe '#new' do
    it 'checks which module to use for sending' do
      mock(subject).klass_for(:https).once{ stub(Object.new).new }
      subject.new(:one,:two,'message',{:module => :https})
    end

    it 'returns a new SMS object of the appropriate module' do
      subject.new(1,2,'message',{:module => :http}).class.must_equal MessageBird::HTTP::SMS
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
