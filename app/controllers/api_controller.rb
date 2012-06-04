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
    
    ret = {:status => 0}
    ret[:config] = {
      #:sina_callback=>SINA_CALLBACK,
      #:sina_client_id=>SINA_CLIENT_ID,
      :server_time => Time.now.to_i
    }
    unless params[:userinfo_version].blank?
      uiv = params[:userinfo_version].to_i
      if uiv < @device.user.updated_at.to_i
        userinfo = {:version =>@device.user.updated_at.to_i}
        userinfo[:name] = @device.user.name if @device.user.name
        userinfo[:default_tee] = @device.user.tee if @device.user.tee
        userinfo[:score_mode] = @device.user.score_mode if @device.user.score_mode

        if @device.user.sina_expires 
          diff = @device.user.sina_expires.to_i - Time.now.localtime.to_i
          userinfo[:sina_expires] = diff if diff > 0
        end
        ret[:userinfo] = userinfo
      end
    end
    
    render json: ret
  end

  def course_list
    return render json: {:status=>1, :message=>'缺少参数'} if params[:lat_lon].blank? && params[:area_id].blank?
    
    hot = Course.find(:all, :conditions => ["courses.id in (?)", [1133, 1454, 1585]])
      .collect { |e| 
        {:id=>e.id, :name=>e.vip ? e.name || e.club.name : e.club.name, :pic=>e.images ? e.images[0].url : ''}
      }
    list = Course.find(:all, :conditions => ["courses.id in (?)", [510, 516, 525, 804, 1133, 1164, 1454, 1585]])
      .collect { |e| 
        {:id=>e.id, :name=> e.vip ? e.name || e.club.name : e.club.name, 
          :logo=>e.club.logo_url, :lat_lon=>"#{e.club.latitude}|#{e.club.longitude}",
          :overall=>rand_rank, :price=>rand_rank, :hardness=>rand_rank, :view=>rand_rank, :cost=>rand_cost}
      }   
    
    render json: {:status=>0, :version=>Time.now.to_i, :hot=>hot, :list=>list}  
  end
  
  def course_info
    id = params[:id]
    return render json: {:status=>1, :message=>'缺少参数'} if id.blank?
    course = Course.find(id)
    return render json: {:status=>14, :message=>'球场不存在'} unless course
    info = {:id => course.id, :name => course.vip ? course.name || course.club.name : course.club.name }
    info[:pics] = course.images.collect { |i| i.url }

    info[:description] = course.description || course.club.description
    info[:designer] = course.designer ||'David M.Dale'
    info[:type] = course.course_type || '山地'
    info[:lat_lon] = "#{course.club.latitude}|#{course.club.longitude}"
    info[:favorite] = true if Favorite.find_by_course_id_and_user_id(course.id, @device.user.id)
    
    comments = Comment.connection.select_one("select count(*) as 'votes', avg(overall) as 'overall', 
                 avg(view) as 'view', avg(rational) as 'rational', avg(hardness) as 'hardness', avg(candy) as 'candy', avg(design) as 'design', 
                 avg(facility) as 'facility', avg(maintenance) as 'maintenance', avg(price) as 'price'
               from comments
               where course_id=#{course.id}")
    if (comments['votes']>0)
      info[:comments] = {:overall=>comments['overall'].to_f, :votes=>comments['votes'], 
        :view=>comments['view'].to_f, :rational=>comments['rational'].to_f, :hardness=>comments['hardness'].to_f, :candy=>comments['candy'].to_f, :design=>comments['design'].to_f, 
        :facility=>comments['facility'].to_f, :maintenance=>comments['maintenance'].to_f, :price=>comments['price'].to_f
      } 
    else
      info[:comments] = {:overall=>0, :votes=>0}
    end
    comments = Comment.find_by_course_id_and_user_id(course.id, @device.user.id)
    if (comments)
      info[:comments_mine] = {
        :overall=>comments.overall.to_f, :view=>comments.view.to_f, :rational=>comments.rational.to_f, :hardness=>comments.hardness.to_f, :candy=>comments.candy.to_f, 
        :design=>comments.design.to_f, :facility=>comments.facility.to_f, :maintenance=>comments.maintenance.to_f, :price=>comments.price.to_f
      }
    end
    
    info[:prices] = [{:workdays=>600, :holidays=>1000, :telephone=>course.club.telephone}]
    info[:holes] = course.hole_count
    if course.hole_count == 9 
      brothers = []
      course.club.courses.each { |e|
        next if e.id == course.id
        next unless e.hole_count == 9
        next unless e.name
        brothers << {:id=>e.id, :name=>e.name}
      }
      info[:combined_courses] = brothers if brothers.size > 0
    end
    
    boxes = []
    hole = course.holes[0]
    boxes << 'black' if hole.yard_black && hole.yard_black > 0
    boxes << 'gold'  if hole.yard_gold  && hole.yard_gold > 0
    boxes << 'blue'  if hole.yard_blue  && hole.yard_blue > 0
    boxes << 'white' if hole.yard_white && hole.yard_white > 0
    boxes << 'red'   if hole.yard_red   && hole.yard_red > 0
    unless boxes.size == 5
      info[:tee_boxes] = boxes.join('|')
    end
    
    render json: {:status=>0, :course=>info}
  end
  
  CREDIT_DOWNLOAD_COURSE_MAP = -10
  def fairway_list
    id = params[:id]
    return render json: {:status=>1, :message=>'缺少参数'} if id.blank?    
    course = Course.find(id)
    return render json: {:status=>14, :message=>'球场不存在'} unless course  
    # return render json: {:status=>15, :message=>'积分不足'} unless @device.user.credit+CREDIT_DOWNLOAD_COURSE_MAP >= 0
    
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
        hole[:corners] = {
          :left_lower  => "#{map.lat_left_lower}|#{map.lon_left_lower}",
          :right_lower => "#{map.lat_right_lower}|#{map.lon_right_lower}",
          :left_upper  => "#{map.lat_left_higher}|#{map.lon_left_higher}",
          :right_upper => "#{map.lat_right_higher}|#{map.lon_right_higher}"
        } if map.lat_left_lower
      
        hole[:dim] = "#{map.dim_x}|#{map.dim_y}" if map.dim_x
        
        hole[:pois] = {
          :green_center => map.poi_green_center, 
          :green_front  => map.poi_green_front,
          :green_back   => map.poi_green_back,
          :tee_red      => map.poi_tee_red, 
          :tee_white    => map.poi_tee_white, 
          :tee_blue     => map.poi_tee_blue, 
          :tee_gold     => map.poi_tee_gold, 
          :tee_black    => map.poi_tee_black              
        } if map.poi_green_center
      end
      holes << hole
    }  
    
    #@device.user.add_credit("下载球道图", CREDIT_DOWNLOAD_COURSE_MAP, :course_id=>course.id)
   
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
    p = {:view=>params[:view],:rational=>params[:rational],:hardness=>params[:hardness],
      :candy=>params[:candy],:design=>params[:design],:facility=>params[:facility],:maintenance=>params[:maintenance],:price=>params[:price]}

    comment = Comment.find_by_user_id_and_course_id(@device.user.id, course.id)
    if comment
      comment.update_attributes(p)
    else
#      first = Comment.count(:conditions => ["course_id=?", course.id]) == 0
      Comment.create({:course_id=>course.id, :user_id=>@device.user.id}.merge(p))
=begin      
      if first
        @device.user.add_credit("第一个对球场评分", CREDIT_COMMENT_COURSE, :course_id=>course.id) 
      else
        @device.user.add_credit("球场评分", CREDIT_COMMENT_COURSE, :course_id=>course.id)
      end
=end
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
        {:id=>e.course.id, :name=>e.course.vip ? e.course.name || e.course.club.name : e.course.club.name, :logo=>e.course.club.logo_url, :overall=>rand_rank, :cost=>rand_cost}
      }
      
    render json: {:status=>0, :list=>list}  
  end
  
  def my_comments
    list = Comment.find_all_by_user_id(@device.user_id)
      .collect { |e|
        {:id=>e.course.id, :name=>e.course.vip ? e.course.name || e.course.club.name : e.course.club.name, :logo=>e.course.club.logo_url, :mine=>e.overall, :overall=>rand_rank}
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

    atts[:score_mode] = params[:score_mode] unless params[:score_mode].blank?
    atts[:tee] = params[:default_tee] unless params[:default_tee].blank?
    
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
    
    userinfo = {:version =>@device.user.updated_at.to_i}
    userinfo[:name] = @device.user.name if @device.user.name
    userinfo[:default_tee] = @device.user.tee if @device.user.tee
    userinfo[:score_mode] = @device.user.score_mode if @device.user.score_mode

    if @device.user.sina_expires 
      diff = @device.user.sina_expires.to_i - Time.now.localtime.to_i
      userinfo[:sina_expires] = diff if diff > 0
    end

    render json: {:status=>0, :token=>@device.token, :userinfo=>userinfo}
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
  
  def my_scorecards
    list = ScoreCard.find(:all, :conditions=>['user_id=?', @device.user.id], :order=>'created_at desc').collect { |e|
      {:id=>e.id, :date=>e.created_at.to_date.to_s(:db), :course_id=>e.course_id, :course_name=>e.course.name||e.course.club.short_name||e.course.club.name, :score=>e.score}
    }
    render json: {:status=>0, :list=>list}  
  end
  
  def scorecard_info
    return render json: {:status=>1, :message=>'缺少参数'} if params[:id].blank?    
    card = ScoreCard.find(params[:id])
    return render json: {:status=>14, :message=>'记分卡不存在'} unless card
    items = []
    (1..18).each { |e|
      hole = card.send("hole#{e}")
      next unless hole
      item = {}
      item[:hole] = hole.id
      item[:par] = hole.par
      item[:score] = card.send("score#{e}")
      putts = card.send("putts#{e}")
      item[:putts] = putts if putts
      fairway = card.send("fairway#{e}")
      item[:fairway] = fairway unless fairway.blank?
      sand = card.send("sand#{e}")
      item[:sand] = sand if sand
      pty = card.send("pty#{e}")
      item[:penalty] = pty if pty
      
      items.push item
    }
    
    render json: {:status=>0, :date=>card.created_at.to_date.to_s(:db), 
      :course_id=>card.course_id, :course_name=>card.course.name||card.course.club.name, 
      :tee_box=>card.tee_box, :items=>items }
    
  end
  
  def save_scorecard
    return render json: {:status=>1, :message=>'缺少参数'} if params[:course_id].blank? 
    course = Course.find(params[:course_id])
    return render json: {:status=>14, :message=>'球场不存在'} unless course
    
    c = ScoreCard.new
    c.user = @device.user
    c.course_id = course.id
    c.tee_box = params[:tee_box]
    c.start_hole = params[:start_hole]
    c.course2_id = params[:course2_id] unless params[:course2_id].blank?
    score = 0
    (1..18).each { |i|
      next if params["hole#{i}_id"].blank?
      c.send("hole#{i}_id=", params["hole#{i}_id"].to_i)
      unless params["score#{i}"].blank?
        p = params["score#{i}"].to_i
        score += p
        c.send("score#{i}=", p)
      end
      unless params["putts#{i}"].blank?
        p = params["putts#{i}"].to_i
        c.send("putts#{i}=", p)
      end
      c.send("t_club#{i}=", params["t_club#{i}"]) unless params["t_club#{i}"].blank?
      c.send("fairway#{i}=", params["fairway#{i}"]) unless params["fairway#{i}"].blank?
      unless params["sand#{i}"].blank?
        p = params["sand#{i}"].to_i
        c.send("sand#{i}=", p)
      end
      unless params["penalty#{i}"].blank?
        p = params["penalty#{i}"].to_i
        c.send("pty#{i}=", p)
      end
    }
    c.score = score
    
    if c.save
      render json: {:status=>0}
    else
      render json: {:status=>20, :message=>'保存失败'}
    end
  end
  
private
  def check_token
    token = params[:token]
    return render json: {:status=>1, :message=>'缺少参数'} if token.blank?
    @device = Device.find_by_token token
    return render json: {:status=>2, :message=>'token失效'} unless @device
  end  
  
  def rand_rank
    5 + rand(5) + rand(9)/10.0
  end
  
  def rand_cost
    (5 + rand(5)) * 100
  end
end
