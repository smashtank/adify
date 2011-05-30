module AdifyHelper
  @@tag_number = 0

  def adify_tag(*args)
    
  end

  def random(length)
    Array.new(length){rand 9}.join
  end

  def tag_number
    @@tag_number += 1
  end
end