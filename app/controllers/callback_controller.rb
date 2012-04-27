require 'net/https'
require 'uri'

# https://api.weibo.com/oauth2/authorize?client_id=95122059&response_type=code&redirect_uri=http://125.35.87.198:8015/callback/sina%3Ftoken%3D1234

# code = bdae284e1ee76c46121941cca037077f

# {"access_token":"2.008oBnWB0laH8Gba3282ac84ctMKPB","expires_in":86400,"remind_in":"86392","uid":"1400660627"}

class CallbackController < ApplicationController
  URL_TOKEN = 'https://api.weibo.com/oauth2/access_token'
  CLIENT_ID = '95122059'
  CLIENT_SECRET = 'ab5ae36e2b0ab627db7219fe046d416e'
  
  def sina
    @token, code = params[:token], params[:code]
    if code && @token
      uri = URI.parse(URL_TOKEN)
      req = Net::HTTP::Post.new(url.path)
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
      @data = res.body
    else
      #logger.debug('no CODE found')
      @data = 'no CODE&TOKEN found'
    end
    
    render :layout=>false
  end
  
end
