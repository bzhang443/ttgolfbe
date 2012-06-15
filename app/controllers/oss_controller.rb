class OssController < ApplicationController
  before_filter :authenticate_admin!
  
  def home
  end
  
  def area_list
    @list = {}
    counts = Club.count(:all, :group=>'area_id')
    counts.each_pair { |k, v| 
      c = Area.find(k)
      if c.level == 0
        @list[k] = {:name=>c.name, :count=>v, :subs=>[]}
      else
        unless @list[c.upper_area]
          @list[c.upper_area] = {:name=>c.upper.name, :count=>0, :subs=>[]}
        end
        @list[c.upper_area][:count] += v
        @list[c.upper_area][:subs] << {:id=>k, :name=>c.name, :count=>v}
      end
    }
    
    logger.debug @list
  end
  
  def course_list
    @list = []
    area = params[:area]
    unless area.blank?
      @list = Course.find(:all, 
        :joins => "join clubs on courses.club_id = clubs.id join areas on clubs.area_id=areas.id",
        :conditions => ["clubs.area_id=? or areas.upper_area=?", area, area]
      )
      @area = Area.find(area)
    end
  end
  
  def course_info
    @course = Course.find(params[:id])
  end
  
  def all_logos
    @list = Club.all
  end
end
