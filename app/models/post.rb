class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes, class_name: 'Like', foreign_key: 'post_id'

  validates :title, presence: true, length: { minimum: 3, maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  after_save :post_count_updater

  def post_count_updater
    author.update(posts_counter: author.posts.count)
  end

  # def recent_comments
  #   comments.order(created_at: :desc).limit(5)
  # end
  def recent_comments
    comments.includes(:author).order(created_at: :desc).limit(5)
  end
  
end
