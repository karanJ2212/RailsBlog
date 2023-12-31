class PostsController < ApplicationController
  # def index
  #   @user = User.find(params[:user_id])
  #   params[:user_id]
  #   # @posts = Post.where(user_id:)
  #   @posts = @user.posts
  #   @comments = Comment.all
  # end
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    @comments = Comment.where(post_id: params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(title: post_params[:title], text: post_params[:text], author_id: current_user[:id],
                     comments_counter: 0, likes_counter: 0)
    if @post.save
      redirect_to user_post_path(current_user, @post), notice: 'Post Created Successfully'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
