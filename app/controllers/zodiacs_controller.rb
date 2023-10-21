require 'csv'
require 'date'

class ZodiacsController < ApplicationController
  include ApplicationHelper

  def index
    table = CSV.parse(File.read('db/zodiac_users.csv'), headers: false)
    @users_zodiac = User.where(show: true).where.not(west_zodiac: nil).order(west_zodiac: :asc)
  end

  def find_name
    if params[:find_name].present?
      if params[:find_name][:birthday].split('/')[0].to_i.in?(1..31) && params[:find_name][:birthday].split('/')[1].to_i.in?(1..12)
        @result = {
          birthday: params[:find_name][:birthday],
          zodiac_name: zodiac(params[:find_name][:birthday])
        }
      else
        @error = I18n.t('zodiacs.invalid_date')
      end
    end
  end
end
