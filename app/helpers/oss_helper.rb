module OssHelper
  def url2img (url)
    unless url.blank?
      image_tag url, :alt=>url||''
    end    
  end
  
  def boolean_tag(value)
    if value
      image_tag "/images/true.png", :alt=>"Yes"
    else
      image_tag "/images/false.png", :alt=>"No"
    end
  end  
end
