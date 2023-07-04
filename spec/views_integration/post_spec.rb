require 'rails_helper'
RSpec.describe Post, type: :system do
  user = User.create(name: 'karan', posts_counter: 11, photo: 'https://randomuser.me/api/portraits/thumb/men/77.jpg', bio: 'Teacher from india.')
  subject do
    Post.new(author_id: user.id, title: 'Libero assumenda et dolores.', text: 'Est ullam laborum. Placeat neque minima. Mollitia magnam nostrum.', comments_counter: 1, likes_counter: 1)
  end
  before { subject.save }
  describe 'Post index page' do
    it "I can see the user's profile picture." do
      visit user_posts_path(user.id)
      page.has_css?('.img-fluid')
    end
    it "I can see the user's username." do
      visit user_posts_path(user.id)
      page.has_content?(user.name)
    end
    it 'I can see the number of posts the user has written.' do
      visit user_posts_path(user.id)
      page.has_content?(user.posts_counter)
    end
    it "I can see a post's title." do
      visit user_posts_path(user.id)
      page.has_content?(subject.title)
    end
    it "I can see some of the post's body." do
      visit user_posts_path(user.id)
      page.has_content?(subject.text)
    end
    it 'I can see the first comments on a post.' do
      comment = Comment.new(author_id: user.id, post_id: subject.id, text: 'I like it')
      visit user_posts_path(user.id)
      page.has_content?(comment.text)
    end
    it 'I can see how many comments a post has.' do
      visit user_posts_path(user.id)
      page.has_content?(subject.comments_counter)
    end
    it 'When I click on a post, it redirects me to that posts show page.' do
      visit user_posts_path(user.id)
      click_on 'Libero assumenda et dolores.'
      visit user_post_path(user.id, subject.id)
      page.has_content?(subject.title)
    end
  end
  describe 'Post show page' do
    it "I can see a post's title." do
      visit user_post_path(user.id, subject.id)
      page.has_content?(subject.title)
    end
    it 'I can see who wrote the post.' do
      visit user_post_path(user.id, subject.id)
      page.has_content?(user.name)
    end
    it 'I can see how many comments it has.' do
      visit user_post_path(user.id, subject.id)
      page.has_content?(subject.comments_counter)
    end
    it 'I can see how many likes it has.' do
      visit user_post_path(user.id, subject.id)
      page.has_content?(subject.likes_counter)
    end
    it 'I can see the post body.' do
      visit user_post_path(user.id, subject.id)
      page.has_content?(subject.text)
    end
  
end