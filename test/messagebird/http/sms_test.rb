require 'helper'

module MessageBirdHTTPSMSHelper
  def format_recipients(input)
    subject.send :format_recipients, input
  end
end

describe MessageBird::HTTP::SMS do
  include MessageBirdHTTPSMSHelper

  subject{ MessageBird::HTTP::SMS.new('sender',3154447100,'message',{}) }

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

  describe '#format_recipients' do
    it 'converts an integer to string' do
      format_recipients(31541471696).must_equal "31541471696"
    end

    it 'converts an enumerable into a comma-separated string' do
      numbers = [3154147100, "315472000"]
      format_recipients(numbers).must_equal "3154147100,315472000"
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
