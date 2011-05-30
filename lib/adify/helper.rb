module AdifyHelper

  def adify_tag(args)
    item = args.delete(:item) rescue nil
    partial = args.delete(:partial) || 'adify/dfp'
    tag_attributes = adification(item).merge(args)
    #pass in the hash as a parameter too in case they need all the value but don't know the names
    render :partial => partial, :locals => tag_attributes.merge(:tag_attributes => tag_attributes.clone)
  end

  def random(length)
    Array.new(length){rand 9}.join
  end

  def tag_number
    @controller.class.adify_tag_number += 1
  end
end