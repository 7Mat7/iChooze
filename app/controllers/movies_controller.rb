class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new
  end

  def index
    @movies = Movie.all
  end

  def redirect
  end
end
