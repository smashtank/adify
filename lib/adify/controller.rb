module Adify
  module Controller
    def self.included(base)
      base.send :extend, ClassMethods
    end

    #TODO: refactor this up so both model and controller use same code.  DRY
    module ClassMethods
      def adify(*args)
        class_eval <<-EOV
          cattr_accessor :adify_#{self.to_s.tableize.gsub(/\//,'_')}_attributes
          cattr_accessor :adify_tag_number

          def self.adify_attributes=(hash)
            self.adify_#{self.to_s.tableize}_attributes = hash
          end

          def self.adify_attributes
            self.ancestors[1].adify_attributes.deep_merge(self.adify_#{self.to_s.tableize.gsub(/\//,'_')}_attributes) rescue self.adify_#{self.to_s.tableize.gsub(/\//,'_')}_attributes
          end
        EOV

        attr_accessor :adify_instance_attributes
        helper_method :adification
        send :include, ::Adify::InstanceMethods

        def self.adification
          @adification_of_item = self.adify_attributes.update_values{|v| get_adify_value(self,v)}
        end

        private
          def get_adify_value(item,value)
            case value.class.to_s
              when 'Array'  then value.each.collect{|v| get_adify_value(item,v)}
              when 'Proc'   then value.call item
              when 'Hash'   then value.update(value){|k,v| get_adify_value(item,v)}
              when 'Symbol' then item.respond_to?(value) ? item.send(value) : value
              else value
            end
          end
        self.adify_attributes = *args
        self.adify_tag_number = 0
      end
    end
  end
end