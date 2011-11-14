require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class Item < ActiveRecord::Base
  adify :item_only => :id, :override_by_item => 'item'

  def id
    "item id via symbol"
  end

  def proc
    "item return"
  end
end

class Thing < ActiveRecord::Base
  adify :item_only => 'thing', :override_by_item => 'item'

  def id
    "item id via symbol"
  end

  def proc
    "thing return"
  end
end

class MyBaseController < ActionController::Base
  adify :override_by_item => 'Base', :base_only => ['base_arry_only_1', {:item1 => 'base array only 2'}], :override_by_controller => 'base', :override_by_action => 'base'
end

class MyController < MyBaseController
  adify :override_by_item => 'Controller', :controller_only => :symbol_no_method, :override_by_controller => 'controller', :override_by_action => 'controller'

  def index
    #maybe rename this
    adify(:override_by_item => "Action", :override_by_action => 'Action', :index_only => Proc.new(){|item| item.proc})
    @adtag = adification(Item.new)
  end

  def show
    adify(:override_by_item => "Action", :override_by_action => 'Action', :show_only =>'foo')
    [adification(Item.new), adification(Thing.new)]
  end
end

describe Adify do
  describe 'adification' do
    it "should merge things properly" do
      adify = MyController.new.index
      adify.should_not be_nil
      adify.should == {
          :override_by_item       => "item",
          :base_only              => ["base_arry_only_1", {:item1 => "base array only 2"}],
          :override_by_controller => "controller",
          :override_by_action     => "Action",
          :controller_only        => :symbol_no_method,
          :index_only            => "item return",
          :item_only              => "item id via symbol"
      }
    end

    it "should not share adify attributes between classes" do
      adifications = MyController.new.show
      adifications.first.should == {:override_by_item=>"item", :base_only=>["base_arry_only_1", {:item1=>"base array only 2"}], :override_by_controller=>"controller", :override_by_action=>"Action", :controller_only=>:symbol_no_method, :item_only => 'item id via symbol', :show_only => 'foo'}
      adifications.last.should == {:override_by_item=>"item", :base_only=>["base_arry_only_1", {:item1=>"base array only 2"}], :override_by_controller=>"controller", :override_by_action=>"Action", :controller_only=>:symbol_no_method, :item_only=>"thing", :show_only => 'foo'}
    end
  end
end
