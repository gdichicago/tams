class CoursesController < ApplicationController
  before_action :set_course, only: [:ta_list, :show, :edit, :update, :destroy]

  def index
    render 'shared/admin_only' unless is_admin?
    @upcoming = Course.upcoming.sort_by(&:date).reverse
    @past = Course.past.sort_by(&:date).reverse
  end

  def new
    render 'shared/admin_only' unless is_admin?
    @course = Course.new
    @series = Series.all
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to courses_path, notice: 'Course was successfully created.'
    else
      @course = Course.new
      @series = Series.all
      redirect_to new_course_path, notice: 'Oh, no! Course was not successfully created.'
    end
  end

  def show
  end

  def edit
    render 'shared/admin_only' unless is_admin?
    @series = Series.all
  end

  def update
    if @course.update(course_params)
      redirect_to courses_path, notice: 'Course was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @course.destroy
      notice = 'Course was successfully deleted.'
    else
      notice = 'Course could not be deleted. Please try again.'
    end

    redirect_to courses_path, notice: notice
  end

  def ta_list
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:name, :date, :url, :location, :description, :num_tas_needed, :meetup_id, :credit_hours, :series_id, :start_time, :end_time, :email_sent)
    end
end
