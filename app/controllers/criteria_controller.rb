require 'open-uri'
require 'net/http'
require 'openssl'
class CriteriaController < ApplicationController

  def create
  end

  def update
    @criterium = current_user.criterium
    @criterium.update(criteria_params)

    providers = @criterium.platforms
    duration = @criterium.duration
    rating = @criterium.rating.to_f

    search_rating = "%7B\"imdb:score\":%7B\"min_scoring_value\":#{rating}%7D%7D"
    url = URI("https://apis.justwatch.com/content/titles/fr_FR/popular?body=%7B%22age_certifications%22:[],%22content_types%22:[%22movie%22],%22genres%22:[],%22languages%22:null,%22min_price%22:null,%22matching_offers_only%22:null,%22max_price%22:null,%22monetization_types%22:[],%22presentation_types%22:[],%22providers%22:#{providers},%22release_year_from%22:null,%22release_year_until%22:null,%22scoring_filter_types%22:#{search_rating},%22timeline_type%22:null,%22sort_by%22:null,%22sort_asc%22:null,%22page%22:1,%22page_size%22:5%7D")
    file = open(url).read
    movies = JSON.parse(file)

    @movie_duration = []
    movies["items"].each do |movie|
      html_file = open("https://apis.justwatch.com/content/titles/movie/#{movie["id"]}/locale/fr_FR").read
      html_doc = JSON.parse(html_file)
      @movie_duration << { duration: html_doc["runtime"], id: html_doc["id"] }
    end

    @movie_short = []
    @movie_short = @movie_duration.select do |movie|
      if movie[:duration] < duration
        @movie_short << { duration: movie[:duration], id: movie[:id] }
      end
    end

    @choice = @movie_short.sample[:id]
    generate_movie(@choice)
  end

  private

  def criteria_params
    params.require(:criterium).permit(:platforms, :duration, :rating)
  end

  def generate_movie(movie)
    url = "https://apis.justwatch.com/content/titles/movie/#{@choice}/locale/fr_FR"
    html_file = open(url).read
    html_doc = JSON.parse(html_file)
    @urls = []

    helpers.translate_platform(current_user.criterium.platforms).map do |b|
      html_doc["offers"].find do |a|
        if a["urls"]["standard_web"].include?(b)
          @urls << a["urls"]["standard_web"]
        end
      end
    end

    render 'pages/home'
    end
end
