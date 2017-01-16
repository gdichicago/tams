class EmailsController < ApplicationController
  include EmailsHelper

  before_action :set_resources

  def welcome
    @ta = TeachingAssistant.find_by_id(params[:emails][:teaching_assistant])
    @ta.status = Status.find_by_label("pending")
    if @ta.save
      TeachingAssistantMailer.welcome(@ta).deliver
    end
    redirect_to admins_dashboard_path, notice: 'Email delivered, TA upgraded to pending.'
  end

  def monthly
    month = Date.today.strftime("%B")
    courses = Course.upcoming.includes(:series).sort_by(&:date)
    @tas.each do |ta|
      TeachingAssistantMailer.monthly(ta, courses, month).deliver
    end
    redirect_to admins_dashboard_path, notice: 'Monthly emails delivered. Hooray!'
  end

  def confirmation
    @course = Course.find_by_id(params[:course_id])
    update_all_email_flags(@course, @course.hours)
    @tas = @course.tas
    @tas.each do |ta|
      TeachingAssistantMailer.confirmation(ta, @course).deliver
    end
    redirect_to admins_dashboard_path, notice: 'Email confirmation sent.'
  end

  def missing_confirmation
    @course = Course.find_by_id(params[:course_id])
    missing_hours = @course.hours.where(email_sent: false)
    update_all_email_flags(@course, missing_hours)
    missing_hours.map(&:teaching_assistant).each do |ta|
      TeachingAssistantMailer.confirmation(ta, @course).deliver
    end
    redirect_to admins_dashboard_path, notice: 'Email confirmation sent.'
  end

  def forgot
    @ta = TeachingAssistant.find_by_email(params[:email])
    if @ta
      TeachingAssistantMailer.forgot(@ta).deliver
      render json: "Email sent!"
    else
      render json: "Looks like we don't have that email on file."
    end
  end
end
