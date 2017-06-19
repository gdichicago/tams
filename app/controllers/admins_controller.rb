class AdminsController < ApplicationController
  def dashboard
    render 'shared/admin_only' unless is_logged_in?
    @prospective_tas = TeachingAssistant.prospective
  end
end
