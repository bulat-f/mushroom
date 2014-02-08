class UsersController < ApplicationController

  def index
    @users = User.all
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
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_atributes(user_params)
      flash[:success] = "User's atributes are updated"
      redirect_to @user
    else
      flash.now[:error] = "User's atributes are not correct"
      render 'edit'
    end
  end

  def destroy

  end

  private
  
  def user_params
    params.requir(:user).permit(:surname, :name, :patronymic, :sex, :email, :phone, :tutor)
  end
end
