require 'helper'
require 'messagebird'

describe MessageBird do

  subject{ MessageBird }
  let(:config){ MessageBird::Config }

  describe '#configure' do
    it 'it delegates configuration method calls to MessageBird::Config' do
      mock(config).configure.with_any_args.once
      MessageBird.configure do; end
    end

    it 'supports a block' do
      config.configure do
        api_url 'test'
      end
      config.api_url.must_equal 'test'
    end
  end

  describe '#send_text_message' do
    it 'command the SMS object to deliver a message' do
      mock(MessageBird::SMS).deliver(1,2,'testmsg', {:test => :value})
      subject.deliver(1,2,'testmsg', {:test => :value})
    end
  end

end
