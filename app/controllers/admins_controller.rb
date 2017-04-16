class AdminsController < ApplicationController
  before_action :set_resources

  def dashboard
    @prospective_tas = TeachingAssistant.prospective
    render 'shared/admin_only' unless is_admin?
  end
end
