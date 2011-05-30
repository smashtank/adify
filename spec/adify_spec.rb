require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class Item < ActiveRecord::Base
  adify :item_only => :id, :override_by_item => 'item'

  def id
    "item id via symbol"
  end

  def proc
    "proc return"
  end
end

class MyBaseController < ActionController::Base
  adify :override_by_item => 'Base', :base_only => ['base_arry_only_1', {:item1 => 'base array only 2'}], :override_by_controller => 'base', :override_by_action => 'base'
end

class MyController < MyBaseController
  adify :override_by_item => 'Controller', :controller_only => :symbol_no_method, :override_by_controller => 'controller', :override_by_action => 'controller'

  def index
    #maybe rename this
    adify(:override_by_item => "Action", :override_by_action => 'Action', :action_only => Proc.new(){|item| item.proc})
    item = Item.new
    @adtag = adification(item)
  end
end

describe Adify do
  describe 'adification' do
    it "should merge things properly" do
      app = MyController.new
      adify = app.index
      adify.should_not be_nil
      adify.should == {
          :override_by_action     => "Action",
          :override_by_item       => "item",
          :controller_only        => :symbol_no_method,
          :base_only              => ["base_arry_only_1", {:item1 => "base array only 2"}],
          :action_only            => "proc return",
          :override_by_controller => "controller",
          :item_only              => "item id via symbol"
      }
    end
  end
end
