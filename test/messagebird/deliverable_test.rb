require 'helper'

describe MessageBird::Deliverable do
  subject{ MessageBird::Deliverable.new }

  describe '#deliver' do
    it 'raises an error' do
      assert_raises( RuntimeError ){ subject.deliver }
    end
  end
end
