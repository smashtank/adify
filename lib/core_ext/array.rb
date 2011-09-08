class Array
  def symbolize_keys_recursively
    self.each do |item|
      if item.is_a? Hash
        item.symbolize_keys_recursively
      elsif item.is_a? Array
        item.symbolize_keys_recursively
      end
    end
  end
end