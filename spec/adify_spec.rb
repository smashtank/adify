require File.expand_path(File.dirname(__FILE__) + '/spec_helper')


describe Adify do
  it "should merge things properly" do
    app = MyController.new
    adify = app.index
    adify.should_not be_nil
    adify.should == {
        :override_by_action     => "Action",
        :override_by_item       => "item",
        :controller_only        => :symbol_no_method,
        :base_only              => ["base_arry_only_1", "base array only 2"],
        :action_only            => "proc return",
        :override_by_controller => "controller",
        :item_only              => "item id via symbol"
    }
  end
end
