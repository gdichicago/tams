class CoursesController < ApplicationController
  before_action :set_course, only: [:ta_list, :edit, :update]

  def index
    render 'shared/admin_only' unless is_admin?
    @courses = Course.all.sort_by(&:date)
  end

  # GET /courses/new
  def new
    render 'shared/admin_only' unless is_admin?
    @course = Course.new
    @series = Series.all
  end

  def edit
    render 'shared/admin_only' unless is_admin?
    @series = Series.all
  end

  # POST /courses
  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to admins_dashboard_path, notice: 'Course was successfully created.'
    else
      redirect_to admins_dashboard_path, error: 'Course was not successfully created. Womp womp.'
    end
  end

  def update
    if @course.update(course_params)
      redirect_to admins_dashboard_path, notice: 'Course was successfully updated.'
    else
      render :edit
    end
  end

  # CUSTOM ROUTES
  def ta_list
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def course_params
      params.require(:course).permit(:name, :date, :url, :location, :description, :num_tas_needed, :meetup_id, :credit_hours, :series_id, :start_time, :end_time, :email_sent)
    end
end
