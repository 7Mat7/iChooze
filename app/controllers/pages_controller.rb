class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  before_action :set_criterium, only: [:home]

  def home
  end

  private

  def set_criterium
    if current_user.present?
      @criterium = current_user.criterium
    else
      @criterium = Criterium.new
    end
  end
end
