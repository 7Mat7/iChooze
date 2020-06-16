class CriteriaController < ApplicationController
  # def edit
  #   @criteria = current_user.criterium
  #   render 'home'
  # end

  def create

  end

  def update
  end

  private

  def criteria_params
    params.require(:criteria).permit(:platforms, :duration, :rating)
  end
end
