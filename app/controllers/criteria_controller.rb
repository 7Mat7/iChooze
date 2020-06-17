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
      html_file = open("https://apis.justwatch.com/content/titles/movie/#{movie["id"]}/locale/en_US").read
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
    url = "https://apis.justwatch.com/content/titles/movie/#{@choice}/locale/en_US"
    html_file = open(url).read
    html_doc = JSON.parse(html_file)

    title = html_doc["title"]
    get_info(title)

    @urls = []

binding.pry
    helpers.translate_platform(current_user.criterium.platforms).map do |b|
      html_doc["offers"].find do |a|
        if a["urls"]["standard_web"].include?(b)
          @urls << a["urls"]["standard_web"]
        end
      end
    end

    render 'pages/home'
  end

  def get_info(movie)
    api_key = ENV["TMDB_KEY"]
    url_for_id = "https://api.themoviedb.org/3/search/movie?api_key=#{api_key}&language=en-US&query=#{movie}&page=1&include_adult=false"
    html_file_for_id = open(url_for_id).read
    html_doc_for_id = JSON.parse(html_file_for_id)
    tmdb_id = html_doc_for_id["results"][0]["id"]

    image_url_base = "https://image.tmdb.org/t/p/w500"

    url_for_info = "https://api.themoviedb.org/3/movie/#{tmdb_id}?api_key=7bf83a9105f9107994967650371b6126&language=en-US"
    html_file_for_info = open(url_for_info).read
    html_doc_for_info = JSON.parse(html_file_for_info)

    url_for_credits = "https://api.themoviedb.org/3/movie/#{tmdb_id}/credits?api_key=7bf83a9105f9107994967650371b6126"
    html_file_for_credits = open(url_for_credits).read
    html_doc_for_credits = JSON.parse(html_file_for_credits)

    director = ""
    html_doc_for_credits["crew"].find do |a|
      if a["job"] == "Director"
        director = a["name"]
      end
    end
    cast = []
    html_doc_for_credits["cast"].first(3).each do |a|
      cast << a["name"]
    end
    title = movie
    rating = html_doc_for_info["vote_average"]
    synopsis = html_doc_for_info["overview"]
    image = image_url_base + html_doc_for_info["poster_path"]
    duration = html_doc_for_info["runtime"]
    date = html_doc_for_info["release_date"]

 Movie.create(title: title, synopsis: synopsis, date: date, duration: duration, rating: rating, director: director, photo_url: image, cast: cast)
  end
end
