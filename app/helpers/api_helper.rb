
module ApiHelper
  def tee_box_tag(name)
    select_tag name, options_for_select(tee_boxes, 'blue')
  end
end
