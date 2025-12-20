class Post < ApplicationRecord
  scope :list, -> { published.order(published_at: :desc).select(:id, :title, :published_at, :status) }

  enum :status, { draft: 0, published: 1 }
end
