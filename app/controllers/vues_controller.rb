class VuesController < ApplicationController
  include SearchList
  def create
    providers = current_user.criterium.platforms
    duration = current_user.criterium.duration
    rating = current_user.criterium.rating
    page = 1
    
    @vue = Vue.new
    @vue.user = current_user
    @movie = Movie.find(params[:movie_id])
    @vue.movie = @movie
    if params[:vue][:conjoint1]
      @vue.conjoint1 = true
    end
    if params[:vue][:conjoint2]
      @vue.conjoint1 = true
    end
    if @vue.save
      search_list(providers, duration, rating, page)
    end
  end

  def movies_params
    params.require(:movie).permit(:id)
  end
end
