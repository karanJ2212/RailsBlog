class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @posts = @user.recent_post
  end

  def index
    @users = User.all
  end
end
