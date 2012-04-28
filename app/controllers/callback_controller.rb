# encoding: utf-8

require 'net/https'
require 'uri'

# https://api.weibo.com/oauth2/authorize?client_id=95122059&response_type=code&redirect_uri=http://125.35.87.198:8015/callback/sina&state=TOKEN

# https://api.weibo.com/oauth2/authorize?client_id=95122059&response_type=code&redirect_uri=http://125.35.87.198:8015/callback/sina&state=e5e468bae1be3f0c868d0fae5653839cfdc8dc6c7f25df81a0c848f05a7d1033
# code = bdae284e1ee76c46121941cca037077f

# {"access_token":"2.008oBnWB0laH8Gba3282ac84ctMKPB","expires_in":86400,"remind_in":"86392","uid":"1400660627"}

class CallbackController < ApplicationController
  URL_TOKEN = 'https://api.weibo.com/oauth2/access_token'
  CLIENT_ID = '95122059'
  CLIENT_SECRET = 'ab5ae36e2b0ab627db7219fe046d416e'
  
  def sina
    token, code = params[:state], params[:code]
    return render json: {:status=>1, :message=>'缺少参数'} unless code && token
    
    device = Device.find_by_token token
    return render json: {:status=>2, :message=>'token不存在'} unless device

    uri = URI.parse(URL_TOKEN)
    req = Net::HTTP::Post.new(uri.path)
    req.form_data = {
      :client_id=>CLIENT_ID, 
      :client_secret=>CLIENT_SECRET, 
      :grant_type=>'authorization_code',
      :redirect_uri=>'http://125.35.87.198:8015/callback/sina',
      :code=>code
    }
    https = Net::HTTP.new(uri.host, 443)
    https.use_ssl = true
    res = https.start {|http| http.request(req) }
    data = JSON(res.body)

    attrs = {:sina_token => data['access_token'], 
      :sina_expires => data['expires_in'].second.from_now.localtime.to_s(:db),
      :sina_uid => data['uid']
    }
    device.user.update_attributes(attrs)
    
    render json: {:status => 0, :expires_in=>attrs[:sina_expires]}
  end
  
end