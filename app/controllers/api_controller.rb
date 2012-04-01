# encoding: utf-8
class ApiController < ApplicationController
  before_filter :check_token, :except => [:index, :sign_up]
  
  def index
    x = Device.first
    @token = x ? x.token : ''
  end

  def sign_up    
    did, model, os, version, source = params[:did], params[:model], params[:os], params[:version], params[:source]
    return render json: {:status=>1, :message=>'缺少参数'} if did.blank? || model.blank? || os.blank?  || source.blank?
    
    device = Device.find_or_create(did, model, os, version, source)
    
    render json: {:status => 0, :token => device.token}
  end

  def sync_config
    lat_lon = params[:lat_lon]
    return render json: {:status=>1, :message=>'缺少参数'} if lat_lon.blank?
    x, y = lat_lon.split('|')
    logger.debug("sync_config got from (#{x},#{y})")
    
    atts = {}
    atts[:os] = params[:os] unless params[:os].blank?
    atts[:version] = params[:version] unless params[:version].blank?
    @device.update_attributes(atts) unless atts.empty?
    
    config = {:server_time => Time.now.to_i}
    
    render json: {:status => 0, :config => config}
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
  
  def course_list
    lat_lon = params[:lat_lon]
    return render json: {:status=>1, :message=>'缺少参数'} if lat_lon.blank?
    x, y = lat_lon.split('|')
    logger.debug("hot_list got request from (#{x},#{y})")

    by = params[:by]
    return render json: {:status=>1, :message=>'缺少参数'} if by.blank?
    
    list = Course.find(:all, 
        :conditions => ["courses.id in (?)", [1,2,3]]
    ).collect { |e| 
      {:id=>e.id, :name=>e.name || e.club.name, :logo=>e.club.logo_url}
    }
    
    render json: {:status=>0, :list=>list}  
  end
  
  def course_info
    id = params[:id]
    return render json: {:status=>1, :message=>'缺少参数'} if id.blank?
    course = Course.find(id)
    return render json: {:status=>14, :message=>'球场不存在'} unless course
    info = {:name=>course.name || course.club.name}
    if course.images
      info[:pic] = course.images[0].url
    end
    info[:description] = course.description || course.club.description
    info[:designer] = course.designer
    info[:address] = course.club.address
    
    info[:favorite] = false
    info[:comments] = {:overall=>8.0, :votes=>23, :view=>1.0, :culture=>2.0, :hardness=>3.0, :candy=>4.0, :design=>5.0, :facility=>6.0, :recall=>7.0, :service=>8.0, :maintenance=>9.0, :price=>10.0}
    info[:comments_mine] = {:overall=>8.0, :view=>1.0, :culture=>2.0, :hardness=>3.0, :candy=>4.0, :design=>5.0, :facility=>6.0, :recall=>7.0, :service=>8.0, :maintenance=>9.0, :price=>10.0}
    info[:prices] = [{:price_workdays=>600, :price_holidays=>1000, :telephone=>course.club.telephone}]
    
    render json: {:status=>0, :course=>info}
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
    list = Favorite
      .find_all_by_user_id(@device.user_id)
      .collect { |e|
        {:id=>e.course.id, :name=>e.course.name || e.course.club.name, :logo=>e.course.club.logo_url}
      }
      
    render json: {:status=>0, :list=>list}  
  end
  
  def my_comments
    list = Comment
      .find_all_by_user_id(@device.user_id)
      .collect { |e|
        {:id=>e.course.id, :name=>e.course.name || e.course.club.name, :logo=>e.course.club.logo_url, :mine=>e.overall, :overall=>6.7}
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
end
