class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :thumbnail
  has_one_attached :banner
  has_rich_text :body

  has_many :comments, as: :commentable, dependent: :destroy
  # scope latest: {created_at: DESC}

  self.per_page = 10

end
