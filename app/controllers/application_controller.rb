class ApplicationController < ActionController::Base
  protect_from_forgery

  #appropriate landing page if signed in
  def after_sign_in_path(resource_or_scope)
    case resource_or_scope
    when :user, User
      expenses_path
    else
      super
    end
  end

  #admin-only pages
  #
  def admins_only
    unless current_user.admin?
      redirect_to :back, :alert => "You must be signed in as administrator to do that."
    end
  end
end
