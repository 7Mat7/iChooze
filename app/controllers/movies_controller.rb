class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
  end

  def create
  end

  def index
    @vues = current_user.vues.where(conjoint1: true).or(current_user.vues.where(conjoint2: true))
  end

  def redirect
  end
end
