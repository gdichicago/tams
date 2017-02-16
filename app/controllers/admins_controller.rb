class AdminsController < ApplicationController
  before_action :set_resources

  def dashboard
    render 'shared/admin_only' unless is_admin?
    @course = Course.new
  end
end
