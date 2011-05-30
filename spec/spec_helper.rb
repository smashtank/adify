$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'active_record'
require 'action_controller'
require 'rspec'
require 'adify'
require 'sqlite3'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|

end

#ActiveRecord::Schema.verbose = false
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Base.configurations = true
ActiveRecord::Schema.define(:version => 1) do
  create_table :items do |t|
    t.datetime  :created_at
    t.datetime  :updated_at
    t.string    :name
  end
end


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
  adify :override_by_item => 'Base', :base_only => ['base_arry_only_1', 'base array only 2'], :override_by_controller => 'base', :override_by_action => 'base'
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

