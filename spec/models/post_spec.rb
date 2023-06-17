require 'rails_helper'


RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'Test', posts_counter: 0) }
  subject do
    Post.new(author: user, title: 'comment counter check', text: 'text post', comments_counter: 5, likes_counter: 5)
  end

  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'comments_counter must be intiger' do
    subject.comments_counter = 'abs'
    expect(subject).to_not be_valid
  end
  it 'like_counter must be intiger' do
    subject.likes_counter = 'abs'
    expect(subject).to_not be_valid
  end


  describe 'Functionality' do
    let(:user) do
      User.create(
        name: 'John Doe',
        photo: 'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg',
        bio: 'Hello I am a test user',
        posts_counter: 0
      )
    end

    subject do
      user.posts.new(
        title: 'Test Post',
        text: 'This is a test post',
        comments_counter: 0,
        likes_counter: 0
      )
    end

    it 'returns the five most recent comments' do
      10.times do |i|
        subject.comments.create(
          text: "This is the text for comment #{i}",
          author: user
        )
      end

      expect(subject.recent_comments.length).to eq(5)
    end

    it 'updates the posts_counter of the author after saving' do
      expect { subject.save }.to change { user.reload.posts_counter }.by(1)
    end
  end
end
