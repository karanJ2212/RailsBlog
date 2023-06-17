require 'rails_helper'


RSpec.describe User, type: :model do
  subject { User.new(name: 'karan', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'developer from india.') }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'post_counter must be intiger' do
    subject.posts_counter = 'abs'
    expect(subject).to_not be_valid
  end

  describe '#recent_posts' do
    let(:user) { User.create(name: 'Test', posts_counter: 0) }
    let!(:post1) { user.posts.create(title: 'First', likes_counter: 0, comments_counter: 0, created_at: 1.day.ago) }
    let!(:post2) do
      user.posts.create(title: 'Second', likes_counter: 0, comments_counter: 0, created_at: 2.days.ago)
    end
    let!(:post3) { user.posts.create(title: 'Third', likes_counter: 0, comments_counter: 0, created_at: Time.now) }

    it 'returns 3 most recent posts' do
      recent_posts = user.recent_posts
      expect(recent_posts.size).to eq(3)
      expect(recent_posts).to eq([post3, post1, post2])
    end
  end
end
