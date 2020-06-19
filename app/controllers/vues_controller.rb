class VuesController < ApplicationController
  def create_member1
    @vue = Vue.new
    @vue.user = current_user
    @movie = Movie.find(params[:movie_id])
    @vue.movie = @movie
    @vue.conjoint1 = true
    if @vue.save
      redirect_to movie_path(@movie)
    end
  end

def create_member2
    @vue = Vue.new
    @vue.user = current_user
    @movie = Movie.find(params[:movie_id])
    @vue.movie = @movie
    @vue.conjoint2 = true
    if @vue.save
      redirect_to movie_path(@movie)
    end
  end

  def create_members
    @vue = Vue.new
    @vue.user = current_user
    @movie = Movie.find(params[:movie_id])
    @vue.movie = @movie
    @vue.conjoint1 = true
    @vue.conjoint2 = true
    if @vue.save
      redirect_to movie_path(@movie)
    end
  end
  def movies_params
    params.require(:movie).permit(:id)
  end
end
