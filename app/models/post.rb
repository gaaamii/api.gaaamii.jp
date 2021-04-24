class Post < ApplicationRecord
  scope :list, -> { order(published_at: :desc).select(:id, :title, :published_at) }
end
