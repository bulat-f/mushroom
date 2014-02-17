class CoursesController < ApplicationController

  before_action :signed_in_user, only: [:new, :create, :edit, :update]
  before_action :correct_user,   only: [:edit, :update, :destroy]
  before_action :tutor_user,     only: [:new, :create]
  
  def index
    @courses = Course.paginate(page: params[:page])
  end

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.build(course_params)
    if @course.save
      flash[:success] = t(:course_create_success)
      redirect_to courses_path
    else
      flash.now[:warning] = t(:course_create_warning)
      render 'new'
    end
  end

  def edit
  end

  def update

  end

  def show
    @course = Course.find(params[:id])
  end

  def destroy
  end

  private

  def course_params
    params.require(:course).permit(:title, :subject, :hours, :description, :price)
  end
end
