require 'csv'
require 'date'

class ZodiacSuitsController < ApplicationController
  include ApplicationHelper
  
  def index
    @result = {
      west_zodiacs: west_zodiacs_suit(params[:sign]),
      chinese_zodiac_analysis: chinese_zodiac_analysis(params[:chinese_zodiac]),
      five_elements_analysis: five_elements_analysis(params[:element]),
      trigrams_analysis: trigrams_analysis(params[:trigram]),
      west_zodiacs_people_suit: User.where(west_zodiac: west_zodiacs_suit(params[:sign])[:suit].split(', ')),
      west_zodiacs_people_avoid: User.where(west_zodiac: west_zodiacs_suit(params[:sign])[:avoid]),
      chinese_zodiac_people_suit: chinese_zodiac_people_suit_cal,
      chinese_zodiac_people_avoid: chinese_zodiac_people_avoid_cal
    }
  end

  private

  def chinese_zodiac_people_suit_cal
    chinese_zodiac_people = []
    User.where.not(chinese_zodiac: nil).map do |user|
      if chinese_zodiac_analysis(params[:chinese_zodiac])[:suit].split(', ').include?(user.chinese_zodiac.split(' ')[1])
        chinese_zodiac_people.push(user)
      end
    end

    chinese_zodiac_people
  end

  def chinese_zodiac_people_avoid_cal
    chinese_zodiac_people = []
    User.where.not(chinese_zodiac: nil).map do |user|
      if chinese_zodiac_analysis(params[:chinese_zodiac])[:avoid].split(', ').include?(user.chinese_zodiac.split(' ')[1])
        chinese_zodiac_people.push(user)
      end
    end

    chinese_zodiac_people
  end
end
