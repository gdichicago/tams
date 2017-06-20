class CoursesController < ApplicationController
  before_action :admin_only, only: [:index, :new, :edit]
  before_action :set_course, only: [:ta_list, :show, :edit, :update, :destroy]

  def index
    @upcoming = Course.upcoming.sort_by(&:date)
    @past = Course.past.sort_by(&:date).reverse
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to courses_path, notice: 'Course was successfully created.'
    else
      @course = Course.new
      redirect_to new_course_path, notice: 'Oh, no! Course was not successfully created.'
    end
  end

  def show
  end

  def edit
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

  private
    def admin_only
      render 'shared/admin_only' unless is_logged_in?
    end

    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:name, :date, :url, :location, :description, :num_tas_needed, :credit_hours, :start_time, :end_time)
    end
end
