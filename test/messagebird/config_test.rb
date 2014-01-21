# Based on https://github.com/jwkoelewijn/batsir/blob/master/spec/batsir/config_spec.rb
require 'helper'

describe MessageBird::Config do
  let(:api_url_string){ 'https://api.messagebird.com/api/sms' }

  describe "with respect to retrieving variables" do
    it "can check if a key exists" do
      MessageBird::Config.key?(:api_url).must_equal true
      MessageBird::Config.key?(:non_existent).must_equal false
    end

    it "can use brackets" do
      MessageBird::Config[:api_url].must_equal api_url_string
    end

    it "can use fetch method" do
      MessageBird::Config.fetch(:api_url, nil).must_equal api_url_string
    end

    it "returns the default value when variable does not exist" do
      MessageBird::Config.fetch(:non_existing_key, 'default').must_equal 'default'
    end

    it "can use a method with the variable's name" do
      MessageBird::Config.test_mode.must_equal true
    end

    it "can use return the settings in a hash" do
      MessageBird::Config[:dbase] = :test
      hash = MessageBird::Config.to_hash
      hash.keys.include?(:api_url).must_equal true
      hash.keys.include?(:dbase).must_equal true
      hash.values.include?(:test).must_equal true
    end
  end

  describe "with respect to setting variables" do
    it "can set a variable using brackets" do
      MessageBird::Config[:testtest] = "testtest"
      MessageBird::Config.testtest.must_equal "testtest"
    end

    it "can set a variable using a method with the variable's name" do
      MessageBird::Config.testtest = "test1"
      MessageBird::Config[:testtest].must_equal "test1"
    end

    describe "setting multiple variables at once" do
      it "can use setup method" do
        MessageBird::Config.setup({:test_var => "test1", :test_var2 => "test2"})
        MessageBird::Config.test_var.must_equal "test1"
        MessageBird::Config.test_var2.must_equal "test2"
      end

      it "merges given settings with default settings when using setup method" do
        MessageBird::Config.setup({:test_var => "test1", :test_var2 => "test2"})
        MessageBird::Config.api_url.must_equal api_url_string
      end

      describe "with block notation" do
        it "uses yielding" do
          MessageBird::Config.use do |config|
            config[:tester1] = "test1"
            config[:tester2] = "test2"
          end
          MessageBird::Config.api_url.must_equal api_url_string
          MessageBird::Config.tester1.must_equal "test1"
          MessageBird::Config.tester2.must_equal "test2"
        end

        it "uses a block" do
          MessageBird::Config.configure do
            tester3 "test3"
            tester4 "test4"
          end
          MessageBird::Config.api_url.must_equal api_url_string
          MessageBird::Config.tester3.must_equal "test3"
          MessageBird::Config.tester4.must_equal "test4"
        end
      end
    end
  end

  describe "with respect to deleting variables" do
    it "deletes the given key" do
      MessageBird::Config.api_url.nil?.must_equal false
      MessageBird::Config.delete(:api_url)
      MessageBird::Config.api_url.must_equal nil
    end
  end
end

describe MessageBird::Config, "with respect to resetting the configuration" do
  it "resets properly" do
    MessageBird::Config.reset
    MessageBird::Config.to_hash.must_equal MessageBird::Config.defaults
  end
end
