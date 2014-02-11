class UsersController < ApplicationController

  before_action :signed_in_user, only: [:edit, :update, :index]
  before_action :correct_user, only:   [:edit, :update]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Welcome!'
      sign_in(@user)
      redirect_to @user
    else
      flash.now[:warning] = "Error"
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "User's atributes are updated"
      redirect_to @user
    else
      flash.now[:warning] = "User's atributes are not correct"
      render 'edit'
    end
  end

  def destroy

  end

  private
  
  def user_params
    params.require(:user).permit(:surname, :name, :patronymic, :sex, :email, :phone, :tutor, :password, :password_confirmation)
  end

  def signed_in_user
    unless signed_in?
      store_location
      flash[:info] = 'Please sign in.'
      redirect_to signin_path
    end
  end

  def correct_user
    unless current_user?(User.find(params[:id]))
      redirect_to root_path
    end
  end
end
