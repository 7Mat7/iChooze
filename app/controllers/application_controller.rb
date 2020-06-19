class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    ap "je suis la"
    ap session[:search]
    # if resource.sign_in_count == 1
    #   edit_criterium_path(current_user.criterium)
    # else
    if session[:search]
      @criterium = Criterium.new(session[:search])
      @criterium.user = resource
      @criterium.save!
      session[:search] = nil
      edit_criterium_path(@criterium)
    else
      super
    end

    # end
  end
end
