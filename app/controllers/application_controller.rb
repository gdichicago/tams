class ApplicationController < ActionController::Base
  include AdminsHelper
  include ApplicationHelper
  include IconsHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
