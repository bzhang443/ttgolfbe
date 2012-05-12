# encoding: utf-8

require 'net/http'
require 'net/https'
require 'uri'

class ApiController < ApplicationController
  before_filter :check_token, :except => [:index, :sign_up]
  
  def index
    x = Device.first
    @token = x ? x.token : ''
    render :layout=>'api'
  end

  SINA_CALLBACK = 'http://125.35.87.198:8015/callback/sina'
  SINA_CLIENT_ID = '95122059'
  def sync_config
    lat_lon = params[:lat_lon]
    return render json: {:status=>1, :message=>'缺少参数'} if lat_lon.blank?
    
    atts = {}
    atts[:os] = params[:os] unless params[:os].blank?
    atts[:version] = params[:version] unless params[:version].blank?
    @device.update_attributes(atts) unless atts.empty?
    
    config = {:server_time => Time.now.to_i, 
      :sina_callback=>SINA_CALLBACK,
      :sina_client_id=>SINA_CLIENT_ID
    }
    config[:sina_expires] = @device.user.sina_expires if @device.user.sina_expires && (Time.now.localtime < @device.user.sina_expires)
    
    render json: {:status => 0, :config => config}
  end

  def course_list
    return render json: {:status=>1, :message=>'缺少参数'} if params[:lat_lon].blank? && params[:area_id].blank?
    
    hot = Course.find(:all, :conditions => ["courses.id in (?)", [538,1134,1139]]).collect { |e| 
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
    info[:favorite] = true if Favorite.find_by_course_id_and_user_id(course.id, @device.user.id)
    
    comments = Comment.connection.select_one("select count(*) as 'votes', avg(overall) as 'overall', 
                 avg(view) as 'view', avg(culture) as 'culture', avg(hardness) as 'hardness', avg(candy) as 'candy', avg(design) as 'design', 
                 avg(facility) as 'facility', avg(recall) as 'recall', avg(service) as 'service', avg(maintenance) as 'maintenance', avg(price) as 'price'
               from comments
               where course_id=#{course.id}")
    if (comments['votes']>0)
      info[:comments] = {:overall=>comments['overall'].to_f, :votes=>comments['votes'], 
        :view=>comments['view'].to_f, :culture=>comments['culture'].to_f, :hardness=>comments['hardness'].to_f, :candy=>comments['candy'].to_f, :design=>comments['design'].to_f, 
        :facility=>comments['facility'].to_f, :recall=>comments['recall'].to_f, :service=>comments['service'].to_f, :maintenance=>comments['maintenance'].to_f, :price=>comments['price'].to_f
      } 
    else
      info[:comments] = {:overall=>0, :votes=>0}
    end
    comments = Comment.find_by_course_id_and_user_id(course.id, @device.user.id)
    if (comments)
      info[:comments_mine] = {
        :overall=>comments.overall.to_f, :view=>comments.view.to_f, :culture=>comments.culture.to_f, :hardness=>comments.hardness.to_f, :candy=>comments.candy.to_f, 
        :design=>comments.design.to_f, :facility=>comments.facility.to_f, :recall=>comments.recall.to_f, :service=>comments.service.to_f, :maintenance=>comments.maintenance.to_f, :price=>comments.price.to_f
      }
    end
    
    info[:prices] = [{:workdays=>600, :holidays=>1000, :telephone=>course.club.telephone}]
    render json: {:status=>0, :course=>info}
  end
  
  CREDIT_DOWNLOAD_COURSE_MAP = -10
  def fairway_list
    id = params[:id]
    return render json: {:status=>1, :message=>'缺少参数'} if id.blank?    
    course = Course.find(id)
    return render json: {:status=>14, :message=>'球场不存在'} unless course  
    return render json: {:status=>15, :message=>'积分不足'} unless @device.user.credit+CREDIT_DOWNLOAD_COURSE_MAP >= 0
    
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
    
    @device.user.add_credit("下载球道图", CREDIT_DOWNLOAD_COURSE_MAP, :course_id=>course.id)
   
    render json: {:status=>0, :list=>holes}
  end
  
  CACHE = {
      'http://zhy.wa3.cn:8080/GolfManage/cut_images/20120430172330913.jpg'=>'/home/rolea/ttgolfbe/map/1133_01.png',
      'http://zhy.wa3.cn:8080/GolfManage/cut_images/20120430172609.jpg'=>'/home/rolea/ttgolfbe/map/1133_02.png',
      'http://zhy.wa3.cn:8080/GolfManage/cut_images/20120430172800.jpg'=>'/home/rolea/ttgolfbe/map/1133_03.png',
      'http://zhy.wa3.cn:8080/GolfManage/cut_images/20120430172921844.jpg'=>'/home/rolea/ttgolfbe/map/1133_04.png',
      'http://zhy.wa3.cn:8080/GolfManage/cut_images/20120430173127.jpg'=>'/home/rolea/ttgolfbe/map/1133_05.png'
    }
  def fairway_map
    id = params[:id]
    return render json: {:status=>1, :message=>'缺少参数'} if id.blank?    
    hole = Hole.find(id)
    return render json: {:status=>14, :message=>'球洞不存在'} unless hole
    type = 'image/jpeg'
    if hole.map.url.ends_with?('.png')
      type = 'image/png'
    end
    if CACHE[hole.map.url]
      send_file CACHE[hole.map.url], :type => type, :disposition => 'inline'
    else
      data = Net::HTTP.get(URI.parse(hole.map.url))
      send_data data, :type => type, :disposition => 'inline'      
    end
  end
  
  CREDIT_COMMENT_COURSE = 10
  CREDIT_COMMENT_COURSE_FIRST = 20
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
      first = Comment.count(:conditions => ["course_id=?", course.id]) == 0
      Comment.create({:course_id=>course.id, :user_id=>@device.user.id}.merge(p))
      if first
        @device.user.add_credit("第一个对球场评分", CREDIT_COMMENT_COURSE, :course_id=>course.id) 
      else
        @device.user.add_credit("球场评分", CREDIT_COMMENT_COURSE, :course_id=>course.id)
      end
    end
    
    render json: {:status=>0}
  end
  
  def credit_history
    list = CreditHistory.find_all_by_user_id(@device.user_id, :order=>'created_at desc')
      .collect { |e|
        { :date => e.created_at.to_date.to_s(:db), 
        :course_id => e.course_id||'',  :course_name => e.course_id ? e.course.name||e.course.club.name : '',
        :action => e.action, :credit => e.offset }
      }
    render json: {:status=>0, :credit=>@device.user.credit, :list=>list}
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
  
  # TODO: set default_tee
  #       set password????
  def config_user
    atts = {}
    u = @device.user
    unless params[:name].blank?
      return render json: {:status=>11, :message=>'用户名已经设置，不能修改'} if u.name
      return render json: {:status=>12, :message=>'用户名已存在'} if User.find_by_name params[:name]
      atts[:name] = params[:name]
    end
    unless params[:email].blank?
      unless u.email.eql?(params[:email])
        return render json: {:status=>13, :message=>'邮箱已经注册过'} if User.find_by_email params[:email]
      end
      atts[:email] = params[:email]
    end    
    unless params[:pass].blank?
      return render json: {:status=>14, :message=>'密码已经设置'} if u.password
      atts[:password] = params[:pass] 
    end
    
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

  def reset_password
    pass, new_pass = params[:pass], params[:new_pass]
    return render json: {:status=>1, :message=>'缺少参数'} if pass.blank? || new_pass.blank?
    user = User.secure_get(@device.user.name, pass)
    return render json: {:status=>12, :message=>'用户验证错误'} unless user 
    @device.user.update_attribute(:password, new_pass)
    @device.update_token
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
    center = params[:center].split('|')
    centx = center[0].to_f
    centy = center[1].to_f
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
  
  def sina_share
    action, message = params[:action], params[:message]
    return render json: {:status=>31, :message=>'用户没有授权'} unless @device.user.sina_token
    return render json: {:status=>32, :message=>'用户授权时效'} unless Time.now.localtime <= @device.user.sina_expires
    
    uri = URI.parse('https://api.weibo.com/2/statuses/update.json')
    req = Net::HTTP::Post.new(uri.path)
    req.form_data = {
      :access_token=>@device.user.sina_token, 
      :status => message || '我安装了天天高尔夫'
    }
    https = Net::HTTP.new(uri.host, 443)
    https.use_ssl = true
    res = https.start {|http| http.request(req) }
    logger.debug(res.body)
    
    render json: {:status=>0}
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
