class TeachingAssistantsController < ApplicationController
  before_action :set_teaching_assistant, only: [:show, :update]

  def index
    render 'shared/admin_only' unless is_logged_in?
    @tas = TeachingAssistant.all.sort_by(&:name)
  end

  def show
    courses = Course.upcoming.sort_by(&:date)
    @courses = courses.delete_if do |course|
      course.num_tas_still_needed == 0 || course.teaching_assistants.pluck(:private_id).include?(@ta.private_id)
    end
  end

  def new
    @ta = TeachingAssistant.new
  end

  def create
    @ta = TeachingAssistant.new(teaching_assistant_params)
    @ta.status = Status.find_by_label("prospective")
    screeners = {
      about: params[:about],
      how: params[:how],
      why: params[:why]
    }

    if @ta.save
      TeachingAssistantMailer.pending(@ta).deliver
      AdminMailer.new_ta(@ta, screeners).deliver
      redirect_to teaching_assistant_thanks_path
    else
      render 'new'
    end
  end

  def update
    if is_logged_in? && @ta.update(teaching_assistant_params)
      redirect_to teaching_assistants_path, notice: 'Teaching assistant successfully updated.'
    elsif @ta.update(teaching_assistant_params)
      redirect_to edit_teaching_assistant_path(@ta.private_id), notice: 'Your account has been successfully updated.'
    else
      redirect_to admins_dashboard_path
    end
  end

  def thanks
  end

  private
  def set_teaching_assistant
    @ta = TeachingAssistant.find_by_private_id(params[:private_id])
  end

  def teaching_assistant_params
    params.require(:teaching_assistant).permit(:name, :email, :status_id)
  end
end
