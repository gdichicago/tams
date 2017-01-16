module AdminsHelper
  def is_admin?
    @admin = Admin.find_by_id(session[:current_user_id])
    return true if @admin
  end
end
