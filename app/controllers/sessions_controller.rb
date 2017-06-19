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
      redirect_to login_path, notice: 'Login unsuccessful. Make sure your credentials are correct!'
    end
  end

  def destroy
    destroy_session
    redirect_to root_path
  end

  private
  def session_params
    params.require(:admin).permit(:name, :password)
  end
end
