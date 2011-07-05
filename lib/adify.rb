require 'action_controller'
require "active_record"
require "active_support"

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
      self.class.adify_attributes.adify_merge(ad_attr) rescue ad_attr
    end

    def adification(item = nil)
      ad_attr = item.nil? ? self.adify_attributes : self.adify_attributes.adify_merge(item.adify_attributes)
      item_for_adification = item.nil? ? self : item
      @adification_of_item = ad_attr.update_values{|v| get_adify_value(item_for_adification,v)}
    end

    private
    def get_adify_value(*args)
      self.class.send(:get_adify_value, *args)
    end
  end
end

class ActiveRecord::Base
  include Adify::Model
end

class ActionController::Base
  include Adify::Controller
  helper_method :adification, :registered_ad_spots, :register_ad_spot

  @registered_ad_spots
  def registered_ad_spots
    @registered_ad_spots || []
  end

  def register_ad_spot(val)
    @registered_ad_spots ||= []
    @registered_ad_spots << val
  end

  def self.adification
    @adification_of_item = self.adify_attributes.update_values{|v| get_adify_value(self,v)}
  end
end

class ActionView::Base
  include AdifyHelper
end


class Hash
  def update_values(&block)
    self.update(self){|k,v| block.call v}
  end
  def adify_merge(h)
    self.merge!(h) {|key, _old, _new| if _old.class == Hash then _old.adify_merge(_new) else _new end  }
  end
end