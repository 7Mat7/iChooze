class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
    @vue = Vue.new
  end

  def create
  end

  def index
    @vues = current_user.vues.where(conjoint1: true).or(current_user.vues.where(conjoint2: true))
    @couple = @vues.select { |v| v.conjoint1 && v.conjoint2 }
    @conjoint1 = @vues.select { |v| v.conjoint1 }
    @conjoint2 = @vues.select { |v| v.conjoint2 }

  end

  def redirect
  end
end
