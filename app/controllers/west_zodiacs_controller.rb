require 'csv'
require 'date'

class WestZodiacsController < ApplicationController
  include ApplicationHelper
  def index
    @result = {}
  
    case params[:sign]

    when 'Ma Kết'
      @result = {
        love: 'Kim Ngưu',
        friend: 'Song Ngư',
        avoid_love: 'Bạch Dương'
      }
    when 'Bảo Bình'
      @result = {
        love: 'Song Tử, Bạch Dương',
        friend: 'Song Tử',
        avoid_love: 'Bọ Cạp'
      }
    when 'Song Ngư'
      @result = {
        love: 'Bọ Cạp',
        friend: 'Cự Giải',
        avoid_love: 'Bảo Bình'
      }
    when 'Bạch Dương'
      @result = {
        love: 'Bảo Bình',
        friend: 'Nhân Mã',
        avoid_love: 'Cự Giải'
      }
    when 'Kim Ngưu'
      @result = {
        love: 'Ma Kết, Cự Giải, Xử Nữ',
        friend: 'Xử Nữ',
        avoid_love: 'Song Tử'
      }
    when 'Song Tử'
      @result = {
        love: 'Thiên Bình, Bảo Bình',
        friend: 'Bảo Bình',
        avoid_love: 'Xử Nữ'
      }
    when 'Cự Giải'
      result = {
        love: 'Kim Ngưu, Song Ngư, Bọ Cạp',
        friend: 'Song Ngư',
        avoid_love: 'Ma Kết'
      }
    when 'Sư Tử'
      @result = {
        love: 'Nhân Mã',
        friend: 'Song Tử, Kim Ngưu, Bạch Dương',
        avoid_love: 'Thiên Bình'
      }
    when 'Xử Nữ'
      @result = {
        love: 'Kim Ngưu',
        friend: 'Kim Ngưu',
        avoid_love: 'Nhân Mã'
      }
    when 'Thiên Bình'
      @result = {
        love: 'Song Tử',
        friend: 'Bọ Cạp',
        avoid_love: 'Song Ngư'
      }
    when 'Bọ Cạp'
      @result = {
        love: 'Song Ngư',
        friend: 'Thiên Bình',
        avoid_love: 'Sư Tử'
      }
    when 'Nhân Mã'
      @result = {
        love: 'Bạch Dương, Sư Tử',
        friend: 'Bạch Dương',
        avoid_love: 'Kim Ngưu'
      }
    else
    end
    
    @result
  end
end
