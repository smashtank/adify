require "adify/version"
require "adify/helper"
require "core_ext/hash"
require "core_ext/array"

module Adify
  def self.included(base)
    base.send :extend, Adify
  end
  
  def adify(args)
    if self.class == Class
      include Adify::Methods
      extend  Adify::Methods
    end
    singleton = class << self; self; end
      singleton.module_eval do
          define_method(:adify_attributes=) do |hash|
            @adify_attributes = hash
          end
      end
    
    self.adify_attributes = args
  end
  
  module Methods
    def adify_attributes
      my_attributes = get_adify_attributes
      merge_with = self.respond_to?(:ancestors) ? self.ancestors.slice(1,self.ancestors.length).select{|c| c.respond_to?(:adify_attributes)}.first : self.class
      merge_with.respond_to?(:adify_attributes) ? merge_with.adify_attributes.adify_merge(my_attributes) : my_attributes
    end
    
    def adification(item = nil)
      ad_attr = item.nil? ? self.adify_attributes : self.adify_attributes.adify_merge(item.adify_attributes)
      item_for_adification = item.nil? ? self : item
      ad_attr.update_values{|v| get_adify_value(item_for_adification,v)}.symbolize_keys_recursively.clone
    end
    
    private
      def get_adify_attributes
        (@adify_attributes || {}).clone
      end
      def get_adify_value(item,value)
        case value.class.to_s
          when "Array"  then value.each.collect{|v| get_adify_value(item,v)}
          when "Proc"   then (value.call item).to_s
          when "Hash"   then value.update(value){|k,v| get_adify_value(item,v)}
          when "Symbol" then item.respond_to?(value) ? item.send(value) : value
          else value
        end
      end
      
  end
end

ActiveRecord::Base.send :include, Adify
ActionController::Base.send :include, Adify
ActionView::Base.send :include, Adify::Helper
