class EnrollmentsController < ApplicationController

  before_action :signed_in_user

  def create
    @course = Course.find(params[:enrollment][:learning_course_id])
    current_user.learn_course!(@course)
    respond_to do |format|
      format.html { redirect_to @course }
      format.js
    end
  end

  def destroy
    @course = Enrollment.find(params[:id]).user
    current_user.unsubscribe!(@course)
    respond_to do |format|
      format.html { redirect_to @course }
      format.js
    end
  end
end
