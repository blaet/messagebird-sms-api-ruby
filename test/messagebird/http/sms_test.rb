require 'helper'

module MessageBirdHTTPSMSHelper
  def format_recipients(input)
    subject.send :format_recipients, input
  end

  def sender_telephone_number?(input)
    subject.send :sender_telephone_number?, input
  end

  def sender_string?(input)
    subject.send :sender_string?, input
  end
end

describe MessageBird::HTTP::SMS do
  include MessageBirdHTTPSMSHelper

  let(:subject_class){ MessageBird::HTTP::SMS }

  subject{ subject_class.new('sender',3154447100,'message') }

  describe '#initialize' do
    it 'delegates setting sender to a setter method' do
      any_instance_of(MessageBird::HTTP::SMS) do |klass|
        mock.proxy(klass).sender=('footest')
      end
      subject_class.new('footest',3154447100,'message')
    end
  end

  describe '#api_url' do
    it 'retrieves the api_url from the Config object' do
      mock(MessageBird::Config).api_url{'test'}
      subject.api_url
    end

    it 'caches the result' do
      mock(MessageBird::Config).api_url.once{'test'}
      subject.api_url
      subject.api_url
    end
  end

  describe '#deliver' do
    it 'commands the Sender to deliver itself' do
      mock(MessageBird::HTTP::Sender).deliver(subject)
      subject.deliver
    end
  end

  describe '#ensure_valid_sender!' do
    it 'works as designed' do
      stub(subject).sender_valid?{true}
      subject.send :ensure_valid_sender!, 'test'

      stub(subject).sender_valid?{false}
      assert_raises(MessageBird::HTTP::SMS::SenderInvalid){
        subject.send :ensure_valid_sender!, 'test'
      }
    end
  end

  describe '#format_recipients' do
    it 'converts an integer to string' do
      format_recipients(31541471696).must_equal "31541471696"
    end

    it 'converts an enumerable into a comma-separated string' do
      numbers = [3154147100, "315472000"]
      format_recipients(numbers).must_equal "3154147100,315472000"
    end
  end

  describe '#sender=' do
    it 'sets the sender when valid' do
      subject.send :sender=, 'footest'
      subject.sender.must_equal 'footest'
    end

    it 'throws an exception if sender not valid' do
      assert_raises(MessageBird::HTTP::SMS::SenderInvalid){
        subject.send :sender=, 'garbledeegook'
      }
    end
  end

  describe '#sender_telephone_number?' do
    it 'detects valid numbers' do
      assert sender_telephone_number?('+31571000000')
      assert sender_telephone_number?('+31671000000')
      assert sender_telephone_number?('+15551234567')
    end

    it 'detects invalid numbers by length' do
      refute sender_telephone_number?('+315710000001') # too long
      refute sender_telephone_number?('+3157100001') # too short
    end

    it 'detects invalid numbers by spaces' do
      refute sender_telephone_number?('+31571000 00')
      refute sender_telephone_number?(' +31571000 0')
      refute sender_telephone_number?('+3157100000 ')
    end
  end

  describe '#sender_string?' do
    it 'detects valid strings' do
      assert sender_string?('A')
      assert sender_string?('StaffingAge')
    end

    it 'detects invalid strings by length' do
      refute sender_string?('StaffingAgency')
      refute sender_string?('')
    end

    it 'detects invalid strings by characters' do
      refute sender_string?('Nedap Flex')
      refute sender_string?(' Nedap')
      refute sender_string?('Nedap ')
    end
  end

  describe '#sender_valid?' do
    it 'works as designed' do
      stub(subject).sender_string?{true}
      stub(subject).sender_telephone_number?{true}
      assert subject.send(:sender_valid?, 'test')

      stub(subject).sender_string?{false}
      stub(subject).sender_telephone_number?{true}
      assert subject.send(:sender_valid?, 'test')

      stub(subject).sender_string?{true}
      stub(subject).sender_telephone_number?{false}
      assert subject.send(:sender_valid?, 'test')

      stub(subject).sender_string?{false}
      stub(subject).sender_telephone_number?{false}
      refute subject.send(:sender_valid?, 'test')
    end
  end

  describe '#password' do
    it 'retrieves the password from the Config object' do
      mock(MessageBird::Config).password{'test'}
      subject.password
    end

    it 'escapes the result' do
      stub(MessageBird::Config).password{'test'}
      mock(subject).escape('test')
      subject.password
    end

    it 'caches the result' do
      mock(MessageBird::Config).password.once{'test'}
      subject.password
      subject.password
    end
  end

  describe '#password=' do
    it 'escapes the input and saves it' do
      mock(subject).escape('test')
      subject.send 'password='.to_sym, 'test'
    end

    it 'saves the result in a variable' do
      stub(subject).escape('test'){'tost'}
      subject.send 'password='.to_sym, 'test'
      subject.password.must_equal 'tost'
    end
  end

  describe '#request_uri' do
    it 'delegates the call to uri' do
      mock(subject.uri).request_uri.once
      subject.request_uri
    end
  end

  describe '#set_optional_variables' do
    let(:options){ {:test=>'blaat', :tast=>'bloat'} }

    it 'tries to set the appropriate instance variables' do
      assert_raises(NoMethodError){ subject.send :set_optional_variables, options}
    end
  end

  describe '#test_mode' do
    it 'fetches the test_mode from the Config object' do
      mock(MessageBird::Config).fetch(:test_mode, true)
      subject.test_mode
    end

    it 'converts to integer boolean values for false' do
      mock(MessageBird::Config).fetch(:test_mode, true){false}
      subject.test_mode.must_equal 0
    end

    it 'converts to integer boolean values for true' do
      mock(MessageBird::Config).fetch(:test_mode, true){true}
      subject.test_mode.must_equal 1
    end

    it 'returns a true value if the config option is unset or nil' do
      # No config options set
      subject.test_mode.must_equal 1
    end
  end

  describe '#test_mode=' do
    it 'sets the corresponding variable' do
      subject.send 'test_mode=', false
      subject.test_mode.must_equal 0

      subject.send 'test_mode=', true
      subject.test_mode.must_equal 1
    end

    it 'raises an ArgumentError when parameter is not a boolean' do
      assert_raises(ArgumentError){ subject.send('test_mode='.to_sym, 'test') }
    end
  end

  describe '#uri' do
    it 'parses its url into a uri' do
      mock(URI).parse(subject.url)
      subject.uri
    end

    it 'caches the result in a variable' do
      stub(URI).parse{'testval'}
      subject.uri
      mock(URI).parse.never
      subject.uri
    end
  end

  describe '#url' do
    it 'returns a string with http in it' do
      assert(subject.url.include?('http'), "Not a valid URL: #{subject.url}")
    end
  end

  describe '#username' do
    it 'retrieves the username from the Config object' do
      mock(MessageBird::Config).username{'test'}
      subject.username
    end

    it 'escapes the result' do
      stub(MessageBird::Config).username{'test'}
      mock(subject).escape('test')
      subject.username
    end

    it 'caches the result' do
      mock(MessageBird::Config).username.once{'test'}
      subject.username
      subject.username
    end
  end

end
