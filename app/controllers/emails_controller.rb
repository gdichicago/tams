class EmailsController < ApplicationController
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
    courses = Course.upcoming.sort_by(&:date)
    @tas.each do |ta|
      TeachingAssistantMailer.monthly(ta, courses, month).deliver
    end
    redirect_to admins_dashboard_path, notice: 'Monthly emails delivered. Hooray!'
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
