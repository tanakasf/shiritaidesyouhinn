class ApplicationController < ActionController::Base

  protected

  def after_sign_in_path_for(resource)
    case resource
    when Public
      root_path
    when Admin
      admin_root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name,])
  end
end
