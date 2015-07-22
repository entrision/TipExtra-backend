class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  respond_to :json

  before_action :config_permitted_params, if: :devise_controller?

  protected

  def config_permitted_params
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name]
  end
end
