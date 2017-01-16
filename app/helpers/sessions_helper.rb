module SessionsHelper
  def create_session
    session[:current_user_id] = @admin.id
  end

  def destroy_session
    session[:current_user_id] = nil
    @admin = nil
  end
end
