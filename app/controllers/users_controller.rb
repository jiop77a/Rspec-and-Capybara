class UsersController < ApplicationController

  def index
    @users = User.all
    render :index
  end

  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      # login(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    if @user
      render :show
    else
      flash[:errors] = ["That user doesn\'t exist"]
      redirect_to users_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
