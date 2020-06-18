class VuesController < ApplicationController
  def create
    @vue = Vue.new
    @vue.user = current_user
    @movie = Movie.find(params[:id])
    @vue.movie = @movie
    if @vue.save
      redirect_to movie_path(@movie)
    end
  end
end
