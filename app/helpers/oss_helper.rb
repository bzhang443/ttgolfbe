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
  
  def alert_tag(value)
    if value
      image_tag "/images/alert.png", :alt=>"!"
    end
  end
  
  def area_chain(area)
    if area.upper
      area.upper.name + '/' + area.name
    else
      area.name
    end
  end
end
