require 'helper'
require 'messagebird'

module MessageBirdHelper
  def format_phone_numbers(input)
    subject.send :format_phone_numbers, input
  end
end

describe MessageBird do
  include MessageBirdHelper

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

  describe '#format_phone_numbers' do
    it 'converts an integer to string' do
      format_phone_numbers(31541471696).must_equal "31541471696"
    end

    it 'converts an enumerable into a comma-separated string' do
      numbers = [3154147100, "315472000"]
      format_phone_numbers(numbers).must_equal "3154147100,315472000"
    end
  end

end
