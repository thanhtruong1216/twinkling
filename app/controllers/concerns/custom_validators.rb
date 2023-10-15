module CustomValidators
  extend ActiveSupport::Concern

  VALID_EMAIL_REGEX = URI::MailTo::EMAIL_REGEXP
  VALID_URL_REGEX = /\A(http|https):\/\/[\u{0E00}-\u{0E7F}a-z0-9]+([\-\.]{1}[\u{0E00}-\u{0E7F}a-z0-9]+)*\.[a-z]{2,}(:[0-9]{1,5})?(\/.*)?\z/i
end
