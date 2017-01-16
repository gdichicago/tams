class TeachingAssistantsController < ApplicationController
  before_action :set_teaching_assistant, only: [:edit, :show, :update, :destroy]
  before_action :set_status, only: [:index, :show]

  # GET /teaching_assistants
  def index
    render 'shared/admin_only' unless is_admin?
    @teaching_assistants = TeachingAssistant.all.includes(:status, :hours).sort_by(&:name)
  end

  # GET /teaching_assistants/1
  def show
    courses = Course.upcoming.single_day.sort_by(&:date)
    @courses = courses.delete_if do |course|
      course.teaching_assistants.pluck(:private_id).include?(@teaching_assistant.private_id)
    end
    @series = Series.upcoming.includes(:courses).sort_by(&:end_date)
    @num_available = Course.upcoming.count
    @inactive = Status.find_by_label("inactive")
    @pending = Status.find_by_label("pending")
  end

  def new
    @teaching_assistant = TeachingAssistant.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @teaching_assistant = TeachingAssistant.new(teaching_assistant_params)
    @teaching_assistant.status = Status.find_by_label("prospective")
    screeners = {
      about: params[:about],
      how: params[:how],
      why: params[:why]
    }

    TeachingAssistantMailer.pending(@teaching_assistant).deliver! if @teaching_assistant.save

    if @teaching_assistant.save && is_admin?
      redirect_to admins_dashboard_path, notice: "TA #{@teaching_assistant.name} successfully added and marked as prospective. Remember to process their application!"
    else
      AdminMailer.new_ta(@teaching_assistant, screeners).deliver!
      redirect_to teaching_assistant_thanks_path
    end
  end

  def update
    if is_admin? && @teaching_assistant.update(teaching_assistant_params)
      redirect_to admins_dashboard_path, notice: 'Teaching assistant successfully updated.'
    elsif @teaching_assistant.update(teaching_assistant_params)
      private_id = @teaching_assistant.private_id
      redirect_to teaching_assistant_path(private_id), notice: 'Updated!'
    else
      redirect_to admins_dashboard_path
    end
  end

  def thanks
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teaching_assistant
      @teaching_assistant = TeachingAssistant.find_by_private_id(params[:private_id])
    end

    # Only allow a trusted parameter "white list" through.
    def teaching_assistant_params
      params.require(:teaching_assistant).permit(:name, :email, :status_id)
    end

    def set_status
      @approved = Status.find_by_label("approved")
      @banned = Status.find_by_label("banned")
      @pending = Status.find_by_label("pending")
    end
end
