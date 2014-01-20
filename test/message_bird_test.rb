# require File.join(File.dirname(__FILE__), 'test_helper')
require 'helper'

require 'message_bird'

describe MessageBird do

  describe 'configuration' do
    it 'it delegates configuration method calls to MessageBird::Config' do
      mock(MessageBird::Config).configure.with_any_args.once
      MessageBird.configure do; end
    end

    it 'supports a block' do
      MessageBird::Config.configure do
        api_url 'test'
      end
      MessageBird::Config.api_url.must_equal 'test'
    end
  end

end
