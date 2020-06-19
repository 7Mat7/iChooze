require 'open-uri'
require 'net/http'
require 'openssl'
class CriteriaController < ApplicationController
  include SearchList
  skip_before_action :authenticate_user!, only: [:create]

  def edit
    @criterium = Criterium.find(params[:id])
  end

  def create
    if current_user.nil?
      session[:search] = params.require(:criterium).permit(:duration, :rating, platforms: [])
      redirect_to new_user_session_path, notice: 'Merci de vous connecter pour ...'
    else
      @criterium = Criterium.new(criteria_params)
      @criterium.user = current_user
      @criterium.save!
      update
    end
  end

  def update
    @criterium = current_user.criterium
    @criterium.update(criteria_params)

    providers = @criterium.platforms
    duration = @criterium.duration
    rating = @criterium.rating.to_f
    @page = 1

    search_list(providers, duration, rating, @page)
  end

  private

  def criteria_params
    params.require(:criterium).permit(:duration, :rating, platforms: [])
  end
end
