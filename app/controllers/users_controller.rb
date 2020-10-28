class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show, :new, :create]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  def index
    @users = User.all
  end

  def show  
  end

  def new
    if logged_in?
      redirect_to root_path
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to Alpha Blog, You have successfuly signedup."
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit   
  end

  def update 
    if @user.update(user_params)
      flash[:notice] = "Updated Successfuly!"
      redirect_to @user
    else
      render 'eidt'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account is delete and associated articles are too.."
    redirect_to articles_path
  end

  private 
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "Your can only edit your account"
      redirect_to @user
    end
  end
end
