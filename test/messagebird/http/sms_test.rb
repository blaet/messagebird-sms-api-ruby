require 'helper'

module MessageBirdHTTPSMSHelper
  def format_recipients(input)
    subject.send :format_recipients, input
  end
end

describe MessageBird::HTTP::SMS do
  include MessageBirdHTTPSMSHelper

  subject{ MessageBird::HTTP::SMS.new('sender',3154447100,'message',{}) }

  describe '#format_recipients' do
    it 'converts an integer to string' do
      format_recipients(31541471696).must_equal "31541471696"
    end

    it 'converts an enumerable into a comma-separated string' do
      numbers = [3154147100, "315472000"]
      format_recipients(numbers).must_equal "3154147100,315472000"
    end
  end

end
