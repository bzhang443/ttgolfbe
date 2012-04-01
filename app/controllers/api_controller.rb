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
  
private
  def check_token
    token = params[:token]
    return render json: {:status=>1, :message=>'缺少参数'} if token.blank?
    @device = Device.find_by_token token
    return render json: {:status=>2, :message=>'token不存在'} unless @device
  end  
end
