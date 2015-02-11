require 'spec_helper'

require 'mini_tools/item_factory'

describe MiniTools::ItemFactory do
  class TestItemFactory
    class BaseItem; def initialize(arg1, arg2); end; end
    class CoolItem; def initialize(arg1, arg2); end; end

    include MiniTools::ItemFactory

    map(
      cool_item: CoolItem
    )

    default BaseItem
  end

  describe 'building items' do
    it 'should return the default item for unknown values passing on any extra args' do
      TestItemFactory::BaseItem
        .stubs(:new)
        .with(:arg1, :arg2)
        .returns('base-item')

      assert_equal 'base-item', TestItemFactory.build(:any_item, :arg1, :arg2)
    end

    it 'should return the specific item if set' do
      TestItemFactory::CoolItem
        .stubs(:new)
        .with(:arg1, :arg2)
        .returns('cool-item')

      assert_equal 'cool-item', TestItemFactory.build(:cool_item, :arg1, :arg2)
    end

    it 'should accept a proc that returns the value' do
      TestItemFactory::CoolItem
        .stubs(:new)
        .with(:arg1, :arg2)
        .returns('cool-item')

      assert_equal 'cool-item', TestItemFactory.build(->{:cool_item}, :arg1, :arg2)
    end
  end
end
