class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]
  def index
    @users = User.all.page(params[:page])
   
  end

  def show
    @user = User.find(params[:id])
    @favorites = @user.favorites
    rescue ActiveRecord::RecordNotFound => e
    redirect_to root_path
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to users_path, alert: '不正なアクセスです。'
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
  end
  
  def favorites
    @user = User.find(params[:id])
    @favorites = @user.favorites
  end
  
  def favorites
    @favorite_items = current_user.favorite_items.includes(:user).order(created_at: :desc)
  end
  
  private #セキュリティに強くなる。
  def user_params
   params.require(:user).permit(:username, :email, :profile, :profile_image)
  end
  
end
