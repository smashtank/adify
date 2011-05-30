module Adify
  module Model
    def self.included(base)
      base.send :extend, ClassMethods
    end

    #TODO: refactor this up so both model and controller use same code.  DRY
    module ClassMethods
      def adify(*args)
        @@adify_class_attributes = HashWithIndifferentAccess.new()
        attr_accessor :adify_instance_attributes
        send :include, ::Adify::InstanceMethods

        def self.adify_attributes=(hash)
          @@adify_class_attributes = hash
        end

        def self.adification
          @adification_of_item = self.adify_attributes.update_values{|v| get_adify_value(self,v)}
        end

        def self.adify_attributes
          super.deep_merge(@@adify_class_attributes) rescue @@adify_class_attributes
        end

        private
          def get_adify_value(item,value)
            case value.class
              when Array  then value.each.collect{|v| self.get_adify_value(item,v)}
              when Proc   then (value.call item).to_s
              when Hash   then value.update(value){|k,v| self.get_adify_value(item,v)}
              when Symbol then item.respond_to?(value) ? item.send(value) : value
              else value
            end
          end

        self.adify_attributes = *args
      end
    end
  end
end