require 'net/http'

class ClientController < ApplicationController
  #before_filter :authenticate_admin!
  
  APIBASE = 'http://192.168.1.12:3000/api/'
  #APIBASE = 'http://127.0.0.1:8080/api/'
  TOKEN = 'e5e468bae1be3f0c868d0fae5653839cfdc8dc6c7f25df81a0c848f05a7d1033'
  
  def home
  end
  
  def course_list
    uri = URI.parse(APIBASE + "course_list?token=#{TOKEN}&area_id=1")
    res = Net::HTTP.get(uri)
    @data = JSON(res)
  end
  
  def course_info
    uri = URI.parse(APIBASE + "course_info?token=#{TOKEN}&id=#{params[:id]}")
    res = Net::HTTP.get(uri)
    @data = JSON(res)
  end

  def course_map
    lat_lon = params[:lat_lon]
    lat = lat_lon.split('|')[0]
    lon = lat_lon.split('|')[1]
    render :layout=>false, :locals=>{:lat=>lat, :lon=>lon, :name=>params['name']}
  end
  
  def course_comments
    
  end
  
  def comment_course
    
  end
  
  def fairway_list
    uri = URI.parse(APIBASE + "fairway_list?token=#{TOKEN}&id=#{params[:id]}")
    res = Net::HTTP.get(uri)
    @data = JSON(res)
    @token = TOKEN
  end  
  
end
