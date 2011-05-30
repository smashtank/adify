require 'action_controller'
require "active_record"
require "active_support"

require 'deep_merge'

require 'adify/controller'
require "adify/model"
require "adify/helper"

#methods both controller and models call
module Adify
  module InstanceMethods
    def adify(*args)
      self.adify_instance_attributes =  *args
    end

    def adify_attributes
      ad_attr = self.adify_instance_attributes || {}
      self.class.adify_attributes.deep_merge(ad_attr) rescue ad_attr
    end

    def adification(item = nil)
      ad_attr = item.nil? ? self.adify_attributes : self.adify_attributes.deep_merge(item.adify_attributes)
      item_for_adification = item.nil? ? self : item
      @adification_of_item = ad_attr.update_values{|v| get_adify_value(item_for_adification,v)}
    end

    private
    def get_adify_value(*args)
      self.class.send(:get_adify_value, *args)
    end
  end
end

ActiveSupport.on_load(:active_record) do
  include Adify::Model
end

ActiveSupport.on_load(:action_controller) do
  include Adify::Controller
end

ActiveSupport.on_load(:action_view) do
  include AdifyHelper
end


class Hash
  def update_values(&block)
    self.update(self){|k,v| block.call v}
  end
end