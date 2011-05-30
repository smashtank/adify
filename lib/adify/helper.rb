module AdifyHelper
  @@tag_number = 0

  def adify_tag(*args)
    item = args.delete(:item) rescue nil
    partial = args.delete(:partial) rescue 'adify/dfp'
    tag_attributes = adification(item)
    render_to_string :partial => partial, :locals => tag_attributes
  end

  def random(length)
    Array.new(length){rand 9}.join
  end

  def tag_number
    @@tag_number += 1
  end
end