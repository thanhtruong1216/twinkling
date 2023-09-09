require 'csv'
require 'date'

class ZodiacSuitsController < ApplicationController
  include ApplicationHelper

  before_action :find_user

  def index
    @result = {
      west_zodiacs: west_zodiacs_suit(@user.west_zodiac),
      chinese_zodiac_analysis: chinese_zodiac_analysis(@user.chinese_zodiac),
      five_elements_analysis: five_elements_analysis(@user.destiny),
      trigrams_analysis: trigrams_analysis(@user.destiny),
      west_zodiacs_people_suit: User.where(show: true).where(west_zodiac: west_zodiacs_suit(@user.west_zodiac)[:suit].split(', ')),
      west_zodiacs_people_avoid: User.where(show: true).where(west_zodiac: west_zodiacs_suit(@user.west_zodiac)[:avoid]),
      chinese_zodiac_people_suit: chinese_zodiac_people_suit_cal,
      chinese_zodiac_people_avoid: chinese_zodiac_people_avoid_cal,
      five_elements_people_suit: five_elements_suit_cal,
      five_elements_people_avoid: five_elements_avoid_cal
    }
  end

  private

  def find_user
    @user = User.find_by(slug: params[:sign])
  end

  def chinese_zodiac_people_suit_cal
    chinese_zodiac_people = []
    User.where(show: true).where.not(chinese_zodiac: nil).map do |user|
      if chinese_zodiac_analysis(@user.chinese_zodiac)[:suit].split(', ').include?(user.chinese_zodiac.split(' ')[1])
        chinese_zodiac_people.push(user)
      end
    end

    chinese_zodiac_people
  end

  def chinese_zodiac_people_avoid_cal
    chinese_zodiac_people = []
    User.where(show: true).where.not(chinese_zodiac: nil).map do |user|
      if chinese_zodiac_analysis(@user.chinese_zodiac)[:avoid].split(', ').include?(user.chinese_zodiac.split(' ')[1])
        chinese_zodiac_people.push(user)
      end
    end

    chinese_zodiac_people
  end


  def five_elements_suit_cal
    five_elements_people = []
    User.where(show: true).where.not(chinese_zodiac: nil).map do |user|
      if five_elements_analysis(@user.destiny)[:suit].split(', ').include?(user.destiny.split('-')[0].split(' ')[2])
        five_elements_people.push(user)
      end
    end

    five_elements_people
  end


  def five_elements_avoid_cal
    five_elements_people = []
    User.where(show: true).where.not(chinese_zodiac: nil).map do |user|
      if five_elements_analysis(@user.destiny)[:avoid].split(', ').include?(user.destiny.split('-')[0].split(' ')[2])
        five_elements_people.push(user)
      end
    end

    five_elements_people
  end

  # def trigrams_suit_cal
  #   trigrams_people = []
  #   User.where(show: true).where.not(chinese_zodiac: nil).map do |user|
  #     if trigrams_analysis(params[:trigram])[:suit].split(', ').include?(user.zodiac_name_translate_sex.split(' ')[0])
  #       trigrams_people.push(user)
  #     end
  #   end

  #   trigrams_people
  # end

  # def trigrams_avoid_cal
  #   trigrams_people = []
  #   User.where(show: true).where.not(chinese_zodiac: nil).map do |user|
  #     if trigrams_analysis(params[:trigram])[:avoid].split(', ').include?(user.zodiac_name_translate_sex.split(' ')[0])
  #       trigrams_people.push(user)
  #     end
  #   end

  #   trigrams_people
  # end
end
