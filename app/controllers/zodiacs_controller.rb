require 'csv'
require 'date'

class ZodiacsController < ApplicationController
  include ApplicationHelper

  def index
    table = CSV.parse(File.read('db/zodiac_users.csv'), headers: false)
    @users_zodiac = User.where(show: true).where.not(west_zodiac: nil).order(west_zodiac: :asc)
  end
end
