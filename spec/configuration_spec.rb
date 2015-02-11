require 'spec_helper'

require 'mini_tools/configuration'

describe MiniTools::Configuration do
  class TestConfig
    include MiniTools::Configuration

    allow :setting_1, :setting_2
    allow :setting_3
  end

  subject { TestConfig }

  describe 'configuration' do
    it 'should be configurable using a config block' do
      TestConfig.configure do |config|
        config.setting_1 = 'a-setting'
        config.setting_2 = 'another-setting'
        config.setting_3 = 'a-third-setting'
      end

      assert_equal 'a-setting', TestConfig.config.setting_1
      assert_equal 'another-setting', TestConfig.config.setting_2
      assert_equal 'a-third-setting', TestConfig.config.setting_3
    end

    it 'should raise an error when an unknown setting is used' do
      assert_raises NoMethodError do
        TestConfig.configure do |config|
          config.unkown_setting = 'unknown-setting'
        end
      end
    end

    it 'should be updateable once set' do
      TestConfig.configure do |config|
        config.setting_1 = 'a-setting'
        config.setting_2 = 'another-setting'
      end

      TestConfig.configure do |config|
        config.setting_1 = 'a-revised-setting'
      end

      assert_equal 'a-revised-setting', TestConfig.config.setting_1
      assert_equal 'another-setting', TestConfig.config.setting_2
    end
  end
end
