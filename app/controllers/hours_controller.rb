class HoursController < ApplicationController
  include HoursHelper
  before_action :set_hour, only: [:show, :edit, :update, :destroy]

  def new
    render 'shared/admin_only' unless is_logged_in?
    @hour = Hour.new
    @courses = Course.future_courses.sort_by(&:date).collect { |c| ["#{c.pretty_date} - #{c.name}", c.id] }
    @tas = TeachingAssistant.elligible.sort_by(&:name).collect { |ta| [ta.name, ta.id] }
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @hour = Hour.new(hour_params)
    @hour.num = @hour.course.credit_hours
    private_id = @hour.teaching_assistant.private_id

    if is_logged_in? && @hour.save
      redirect_to courses_path, notice: 'TA hour(s) successfully created.'
    elsif @hour.save
      redirect_to teaching_assistant_path(private_id), notice: 'Got it! See you in class.'
    else
      redirect_to teaching_assistant_path(private_id), notice: 'Oh no, something went wrong! Please try again.'
    end
  end

  def edit
  end

  def update
    if is_logged_in? && @hour.update(hour_params)
      redirect_to courses_path, notice: 'TA hour(s) successfully updated.'
    elsif @hour.update(hour_params)
      private_id = @hour.teaching_assistant.private_id
      redirect_to teaching_assistant_path(private_id), notice: 'RSVP successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @hour.destroy

    if is_logged_in?
      redirect_to courses_path, notice: 'TA hour(s) successfully removed.'
    else
      private_id = @hour.teaching_assistant.private_id
      name = @hour.course.name
      date = @hour.course.date
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
