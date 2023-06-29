# class PostsController < ApplicationController
#   def index
#     user = params[:user_id]
#     @post = Post.where(user_id: user)
#   end

#   def show
#     @post = Post.find_by(author_id: params[:user_id])
#   end
# end

class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    user_id = params[:user_id]
    @posts = Post.where(user_id:)
    @comments = Comment.all
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    @comments = Comment.where(post_id: params[:id])
  end
end
