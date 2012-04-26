# encoding: utf-8
require 'net/http'

class ApiController < ApplicationController
  before_filter :check_token, :except => [:index, :sign_up]
  
  def index
    x = Device.first
    @token = x ? x.token : ''
    render :layout=>'api'
  end

  def sync_config
    lat_lon = params[:lat_lon]
    return render json: {:status=>1, :message=>'缺少参数'} if lat_lon.blank?
    
    atts = {}
    atts[:os] = params[:os] unless params[:os].blank?
    atts[:version] = params[:version] unless params[:version].blank?
    @device.update_attributes(atts) unless atts.empty?
    
    config = {:server_time => Time.now.to_i}
    
    render json: {:status => 0, :config => config}
  end

  def course_list
    return render json: {:status=>1, :message=>'缺少参数'} if params[:lat_lon].blank? && params[:area_id].blank?
    
    hot = Course.find(:all, :conditions => ["courses.id in (?)", [1134,538,1139]]).collect { |e| 
      {:id=>e.id, :name=>e.name || e.club.name, :pic=>e.images ? e.images[0].url : ''}
    }
    list = Course.find(:all, :conditions => ["courses.id in (?)", [1133,1165,104,538,1139,1184]]).collect { |e| 
      {:id=>e.id, :name=>e.name || e.club.name, :logo=>e.club.logo_url, :lat_lon=>"#{e.club.latitude}|#{e.club.longitude}",
        :overall=>rand_rank, :price=>rand_rank, :hardness=>rand_rank, :view=>rand_rank, :cost=>rand_cost}
    }   
    
    render json: {:status=>0, :version=>Time.now.to_i, :hot=>hot, :list=>list}  
  end
  
  def course_info
    id = params[:id]
    return render json: {:status=>1, :message=>'缺少参数'} if id.blank?
    course = Course.find(id)
    return render json: {:status=>14, :message=>'球场不存在'} unless course
    info = {:id => course.id, :name => course.name || course.club.name}
    info[:pics] = course.images.collect { |i| i.url }

    info[:description] = course.description || course.club.description
    info[:designer] = course.designer ||'David M.Dale'
    info[:type] = course.course_type || '山地'
    info[:lat_lon] = "#{course.club.latitude}|#{course.club.longitude}"
    
    info[:favorite] = false
    info[:comments] = {:overall=>8.0, :votes=>23, :view=>1.0, :culture=>2.0, :hardness=>3.0, :candy=>4.0, :design=>5.0, :facility=>6.0, :recall=>7.0, :service=>8.0, :maintenance=>9.0, :price=>10.0}
    info[:comments_mine] = {:overall=>8.0, :view=>1.0, :culture=>2.0, :hardness=>3.0, :candy=>4.0, :design=>5.0, :facility=>6.0, :recall=>7.0, :service=>8.0, :maintenance=>9.0, :price=>10.0}
    info[:prices] = [{:workdays=>600, :holidays=>1000, :telephone=>course.club.telephone}]
    info[:holes] = [1,2,3,4,5]
    render json: {:status=>0, :course=>info}
  end
  
  def fairway_list
    id = params[:id]
    return render json: {:status=>1, :message=>'缺少参数'} if id.blank?    
    course = Course.find(id)
    return render json: {:status=>14, :message=>'球场不存在'} unless course  
    
    holes = []
    Hole.find(:all,
      :include => 'map',
      :conditions => ['course_id = ?', id],
      :order => 'number'
    ).each { |e|
      hole = {:id => e.id, :number => e.number, :par=> e.par}
      yards = {}
      yards['red'] = e.yard_red unless e.yard_red.blank?
      yards['white'] = e.yard_white unless e.yard_white.blank?
      yards['blue'] = e.yard_blue unless e.yard_blue.blank?
      yards['gold'] = e.yard_gold unless e.yard_gold.blank?
      yards['black'] = e.yard_black unless e.yard_black.blank?
      hole['yards'] = yards
      map = e.map
      if map
        if map.lat_left_lower
          hole[:corners] = {
            :left_lower  => "#{map.lat_left_lower}|#{map.lon_left_lower}",
            :right_lower => "#{map.lat_right_lower}|#{map.lon_right_lower}",
            :left_upper  => "#{map.lat_left_higher}|#{map.lon_left_higher}",
            :right_upper => "#{map.lat_right_higher}|#{map.lon_right_higher}"
          }
        end
        if map.dim_x
          hole[:dim] = "#{map.dim_x}|#{map.dim_y}"
        end
        if map.position_green_center
          hole[:pois] = {
            :green_center => map.position_green_center, 
            :tee_red      => map.position_tee_red, 
            :tee_white    => map.position_tee_white, 
            :tee_blue     => map.position_tee_blue, 
            :tee_gold     => map.position_tee_gold, 
            :tee_black    => map.position_tee_black              
          }
        end
      end
      holes << hole
    }  
    
    render json: {:status=>0, :list=>holes}
  end
  
  def fairway_map
    id = params[:id]
    return render json: {:status=>1, :message=>'缺少参数'} if id.blank?    
    hole = Hole.find(id)
    return render json: {:status=>14, :message=>'球洞不存在'} unless hole
    
    # render json: {:status=>0, :url=> hole.map.url}
    data = Net::HTTP.get(URI.parse(hole.map.url))
    send_data data, :type => 'image/jpeg', :disposition => 'inline'
  end
  
  def comment_course
    id = params[:id]
    return render json: {:status=>1, :message=>'缺少参数'} if id.blank?
    course = Course.find(id)
    return render json: {:status=>14, :message=>'球场不存在'} unless course  
    p = {:view=>params[:view],:culture=>params[:culture],:hardness=>params[:hardness],
      :candy=>params[:candy],:design=>params[:design],:facility=>params[:facility],:recall=>params[:recall],
      :service=>params[:service],:maintenance=>params[:maintenance],:price=>params[:price]}

    comment = Comment.find_by_user_id_and_course_id(@device.user.id, course.id)
    if comment
      comment.update_attributes(p)
    else
      Comment.create({:course_id=>course.id, :user_id=>@device.user.id}.merge(p))
    end
    
    render json: {:status=>0}
  end
  
  def add_favorite
    id = params[:id]
    return render json: {:status=>1, :message=>'缺少参数'} if id.blank?
    course = Course.find(id)
    return render json: {:status=>14, :message=>'球场不存在'} unless course  

    record = Favorite.find_by_user_id_and_course_id(@device.user.id, course.id)
    if record
      if 'yes'.eql?(params[:off])
        record.destroy
      end
    else
      unless 'yes'.eql?(params[:off])
        Favorite.create(:user_id=>@device.user.id, :course_id=>course.id)
      end
    end
    
    render json: {:status=>0}
  end
  
  def my_favorites
    list = Favorite.find_all_by_user_id(@device.user_id)
      .collect { |e|
        {:id=>e.course.id, :name=>e.course.name || e.course.club.name, :logo=>e.course.club.logo_url, :overall=>rand_rank, :cost=>rand_cost}
      }
      
    render json: {:status=>0, :list=>list}  
  end
  
  def my_comments
    list = Comment.find_all_by_user_id(@device.user_id)
      .collect { |e|
        {:id=>e.course.id, :name=>e.course.name || e.course.club.name, :logo=>e.course.club.logo_url, :mine=>e.overall, :overall=>rand_rank}
      }
      
    render json: {:status=>0, :list=>list}      
  end
  
  def area_list
    list = [
      {:id=>27, :name=>'北京', :courses=> 67}, 
      {:id=>17, :name=>'广东', :courses=> 70, :subs=>[{:id=>50, :name=>'珠海', :courses=> 8}, {:id=>51, :name=>'佛山', :courses=> 12}, {:id=>66, :name=>'广州', :courses=> 20},  {:id=>254, :name=>'深圳', :courses=> 9},  {:id=>135, :name=>'东莞', :courses=> 5}]},
      {:id=>4, :name=>'上海', :courses=> 32}
      ]
    render json: {:status=>0, :list=>list}
  end
  
  def sign_up    
    did, model, os, version, source = params[:did], params[:model], params[:os], params[:version], params[:source]
    return render json: {:status=>1, :message=>'缺少参数'} if did.blank? || model.blank? || os.blank?  || source.blank?
    
    device = Device.find_or_create(did, model, os, version, source)
    ret = {:status => 0, :token => device.token}
    ret[:user_name] = device.user.name if device.user.name
    
    render json: ret
  end
  
  def config_user
    atts = {}
    u = @device.user
    unless params[:name].blank?
      unless u.name.eql?(params[:name])
        return render json: {:status=>11, :message=>'用户名已存在'} if User.find_by_name params[:name]
      end
      atts[:name] = params[:name]
    end
    unless params[:email].blank?
      unless u.email.eql?(params[:email])
        return render json: {:status=>12, :message=>'邮箱已经注册过'} if User.find_by_email params[:email]
      end
      atts[:email] = params[:email]
    end    
    atts[:password] = params[:pass] unless params[:pass].blank?
    atts[:sina_token] = params[:sina_token] unless params[:sina_token].blank?
    u.update_attributes(atts)    
    
    ret = {:status=>0}
    unless params[:password].blank?
      @device.update_token
      ret[:token] = @device.token
    end
    render json: ret
  end

  def switch_user
    name, pass = params[:name], params[:pass]
    return render json: {:status=>1, :message=>'缺少参数'} if name.blank? || pass.blank?
    user = User.secure_get(name, pass)
    return render json: {:status=>12, :message=>'用户验证错误'} unless user
    
    @device.switch_user(user)
    
    render json: {:status=>0, :token=>@device.token}
  end

  def find_password
    email = params[:email]
    return render json: {:status=>1, :message=>'缺少参数'} if email.blank?
    him = User.find_by_email email
    return render json: {:status=>13, :message=>'邮箱不存在'} unless him
    
    render json: {:status=>0, :message=>'密码已经发送，请查收'}
  end  
  
  def search_suggest
    key = params[:key]
    return render json: {:status=>1, :message=>'缺少参数'} if key.blank?
    list = ["北京#{key}", "#{key}国际", "#{key}高尔夫"]
    render json: {:status=>0, :list=>list} 
  end
  
  def key_search
    key = params[:key]
    return render json: {:status=>1, :message=>'缺少参数'} if key.blank?
    list = Club.find(:all, 
      :conditions=>['name like ?', "%#{key}%"],
      :limit=>16
    ).collect{ |e|
      {:id=>e.id, :name=>e.name}
    }
    render json: {:status=>0, :list=>list}     
  end
  
  KM1 = 0.01
  def map_search
    return render json: {:status=>1, :message=>'缺少参数'} if params[:center].blank? || params[:radius].blank?
    center = params[:center]
    centx = center.split('|')[0].to_f
    centy = center.split('|')[1].to_f
    radius = params[:radius].to_i
    r = radius * KM1
    list = Club.find(:all, 
      :conditions=>['latitude between ? and ? and longitude between ? and ?', centx-r, centx+r, centy-r, centy+r],
      :limit=>16
    ).collect{ |e|
      {:id=>e.id, :name=>e.short_name, :lat_lon=>"#{e.latitude}|#{e.longitude}"}
    }
    if list.size<1 && radius<100
      r = 100 * KM1
      list = Club.find(:all, 
        :conditions=>['latitude between ? and ? and longitude between ? and ?', centx-r, centx+r, centy-r, centy+r],
        :limit=>16
      ).collect{ |e|
        {:id=>e.id, :name=>e.short_name, :lat_lon=>"#{e.latitude}|#{e.longitude}" }
      }
    end
    render json: {:status=>0, :list=>list} 
  end
  
  def hot_list
    lat_lon = params[:lat_lon]
    return render json: {:status=>1, :message=>'缺少参数'} if lat_lon.blank?
    x, y = lat_lon.split('|')
    logger.debug("hot_list got request from (#{x},#{y})")
    
    list = Course.find(:all, 
        :conditions => ["courses.id in (?)", [1,2,3]]
    ).collect { |e| 
      {:id=>e.id, :name=>e.name || e.club.name, :pic=>e.images ? e.images[0].url : ''}
    }
    
    render json: {:status=>0, :list=>list}   
  end
  
private
  def check_token
    token = params[:token]
    return render json: {:status=>1, :message=>'缺少参数'} if token.blank?
    @device = Device.find_by_token token
    return render json: {:status=>2, :message=>'token不存在'} unless @device
  end  
  
  def rand_rank
    5 + rand(5) + rand(9)/10.0
  end
  
  def rand_cost
    (5 + rand(5)) * 100
  end
end
