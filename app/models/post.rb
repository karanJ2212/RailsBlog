class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, foreign_key: :post_id
  has_many :likes, foreign_key: :post_id
  def recent_posts
    comments.order(created_at: :desc).limit(5)
  end

  def update_post_counter
    user.update(posts_counter: author.posts.count)
  end
end