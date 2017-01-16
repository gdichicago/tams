class SessionsController < ApplicationController
  include SessionsHelper

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.find_by_name(params[:name])
    if @admin && @admin.authenticate(params[:password])
      create_session
      redirect_to admins_dashboard_path
    else
      redirect_to new_session_path
    end
  end

  def destroy
    destroy_session
    redirect_to new_session_path
  end

  private
  def session_params
    params.require(:admin).permit(:name, :password)
  end
end
