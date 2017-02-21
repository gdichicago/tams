class HoursController < ApplicationController
  include HoursHelper

  before_action :set_hour, only: [:show, :edit, :update, :destroy]

  def new
    render 'shared/admin_only' unless is_admin?
    @hour = Hour.new
    @courses = Course.future_courses.sort_by(&:date).collect { |c| ["#{c.pretty_date} - #{c.name}", c.id] }
    @tas = TeachingAssistant.elligible.sort_by(&:name).collect { |ta| [ta.name, ta.id] }
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
  end

  def create
    @hour = Hour.new(hour_params)
    private_id = @hour.teaching_assistant.private_id

    build_hour_from(@hour)

    if is_admin?
      redirect_to courses_path, notice: 'TA hour(s) successfully created.'
    elsif @hour.new_record?
      redirect_to teaching_assistant_path(private_id), notice: 'Something went wrong.'
    else
      redirect_to teaching_assistant_path(private_id), notice: 'Got it! See you in class.'
    end
  end

  def mass_create
    series = Series.find(params[:hour][:series_id])
    ta = TeachingAssistant.find(params[:hour][:teaching_assistant_id])
    private_id = ta.private_id

    success = build_series_hours(series, ta)

    if is_admin?
      redirect_to admins_dashboard_path, notice: 'TA hour(s) successfully created.'
    elsif success
      redirect_to teaching_assistant_path(private_id), notice: 'Got it! See you in class.'
    else
      redirect_to teaching_assistant_path(private_id), notice: 'Something went wrong.'
    end
  end

  def update
    if is_admin? && @hour.update(hour_params)
      redirect_to courses_path, notice: 'TA hour(s) successfully updated.'
    elsif @hour.update(hour_params)
      private_id = @hour.teaching_assistant.private_id
      redirect_to teaching_assistant_path(private_id), notice: 'RSVP successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    # TODO: remove?
    # name = @hour.course.name
    # date = @hour.course.date
    @hour.destroy

    if is_admin?
      redirect_to courses_path, notice: 'TA hour(s) successfully removed.'
    else
      private_id = @hour.teaching_assistant.private_id
      redirect_to teaching_assistant_path(private_id), notice: "RSVP cancelled for #{name} on #{date}."
    end
  end

  private
  def set_hour
    @hour = Hour.find(params[:id])
  end

  def hour_params
    params.require(:hour).permit(:course_id, :teaching_assistant_id, :num)
  end
end
