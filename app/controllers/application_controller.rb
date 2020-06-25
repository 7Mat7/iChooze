class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if session[:search]
      @criterium = Criterium.new(session[:search])
      @criterium.user = resource
      @criterium.save!
      session[:search] = nil
      edit_criterium_path(@criterium)
    else
      super
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:conjoint1, :conjoint2])
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end
end
