class Click < ApplicationRecord
  belongs_to :link, counter_cache: true
end
