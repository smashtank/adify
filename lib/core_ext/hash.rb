class Hash
  def update_values(&block)
    self.update(self){|k,v| block.call v}
  end
  def adify_merge(h)
    self.merge!(h) {|key, _old, _new| _old.class == Hash ? _old.adify_merge(_new) : _new  }
  end
  def symbolize_keys_recursively
    self.symbolize_keys!
    self.values.each do |v|
      if v.is_a? Hash
        v.symbolize_keys_recursively
      elsif v.is_a? Array
        v.symbolize_keys_recursively
      end
    end
    self
  end
end