class Link < ApplicationRecord
  validates :url, format: /\A#{URI::regexp(%w(http https))}\z/
end
