require 'csv'
require 'date'

class ZodiacsController < ApplicationController
  include ApplicationHelper
  def index
    table = CSV.parse(File.read('db/users.csv'), headers: false)
    # table = table.sort! do |a,b| 
    #   birthdate_splited = a[3].split('/')
    #   birthdate_splited_b = b[3].split('/')
    
    #   birthdate_result = "#{birthdate_splited[0]}/#{birthdate_splited[1]}/0000}"
    #   birthdate_result_b = "#{birthdate_splited_b[0]}/#{birthdate_splited_b[1]}/0000}"
    
    #   Date.parse(birthdate_result_b) <=>  Date.parse(birthdate_result)
    # end

    @users_zodiac = []

    table.each_with_index do |user, index|
      s = {
        user_name: user[1],
        date_of_birth: user[3],
        zodiac: zodiac(user[3]),
        destiny: destiny(user[3].split('/')[2]),
        year: user[3].split('/')[2].to_i,
        chinese_zodiac: chinese_zodiac(user[3].split('/')[2].to_i),
        zodiac_name_translate: zodiac_name_translate(chinese_zodiac(user[3].split('/')[2].to_i))
      }

      @users_zodiac.push(s)
    end

    @users_zodiac = @users_zodiac.sort { |a,b| a[:year] <=> b[:year] }
  end
end
