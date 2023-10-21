class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :authenticate_user!
  before_action :set_host_for_local_storage
  before_action :set_time_zone
 
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_time_zone
    off_set = Time.now.gmt_offset
    Time.zone = ActiveSupport::TimeZone[off_set].name
  end

  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  def default_url_options
    { locale: I18n.locale }
  end

  private

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

  def set_host_for_local_storage
    if Rails.application.config.active_storage.service == :local
      ActiveStorage::Current.url_options = request.base_url
    end
  end
end
