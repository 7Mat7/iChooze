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
    @conjoint1 = @vues.select { |v| v.conjoint1 && (v.conjoint2 == false) }
    @conjoint2 = @vues.select { |v| v.conjoint2 && (v.conjoint1 == false) }

  end

  def redirect
  end
end
