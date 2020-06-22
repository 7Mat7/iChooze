module SearchList
  def search_list(providers, duration, rating, page)
    search_rating = "%7B\"imdb:score\":%7B\"min_scoring_value\":#{rating}%7D%7D"
    url = URI("https://apis.justwatch.com/content/titles/fr_FR/popular?body=%7B%22age_certifications%22:[],%22content_types%22:[%22movie%22],%22genres%22:[],%22languages%22:null,%22min_price%22:null,%22matching_offers_only%22:null,%22max_price%22:null,%22monetization_types%22:[],%22presentation_types%22:[],%22providers%22:#{providers},%22release_year_from%22:null,%22release_year_until%22:null,%22scoring_filter_types%22:#{search_rating},%22timeline_type%22:null,%22sort_by%22:null,%22sort_asc%22:null,%22page%22:#{page},%22page_size%22:1%7D")
    file = open(url).read
    movies = JSON.parse(file)

    binding.pry
    seen_movies = []
    if current_user.vues.any?
      current_user.vues.each do |vue|
        seen_movies << vue.movie[:title_fr]
      end
    movies_to_parse = movies["items"].reject do |title|
      seen_movies.include? title["title"]
    end
    else movies_to_parse = movies["items"]
    end

    if movies_to_parse.empty?
      page += 1
      search_list(providers, duration, rating, page)
    else
      find_movie(movies_to_parse, duration, page)
    end
   end

  def find_movie(movies, duration, page)
    @criterium = current_user.criterium
    providers = @criterium.platforms
    duration = @criterium.duration
    rating = @criterium.rating.to_f

    @movie_duration = []
    movies.each do |movie|
      html_file = open("https://apis.justwatch.com/content/titles/movie/#{movie["id"]}/locale/fr_FR").read
      html_doc = JSON.parse(html_file)
      @movie_duration << { duration: html_doc["runtime"], id: html_doc["id"] }
    end

    @movie_short = @movie_duration.select do |movie|
      movie[:duration] < duration
    end

    if @movie_short.empty?
      page += 1
      search_list(providers, duration, rating, page)
    else
      @choice = @movie_short.sample[:id]
      generate_movie(@choice)
    end
  end

  def generate_movie(movie)
    url = "https://apis.justwatch.com/content/titles/movie/#{movie}/locale/fr_FR"
    html_file = open(url).read
    html_doc = JSON.parse(html_file)
    urls = []
    helpers.translate_platform(current_user.criterium.platforms).each do |b|
      html_doc["offers"].find do |a|
        if a["urls"]["standard_web"] && a["urls"]["standard_web"].include?(b)
          urls << a["urls"]["standard_web"]
        end
      end
    end

    title_fr = html_doc["title"]
    title = html_doc["original_title"]

binding.pry
    @movie = Movie.find_by(title_fr: title_fr)
    if @movie.present?
      go_to(@movie)
    else
      get_info(title, urls, title_fr)
      go_to(@movie)
    end
  end

  def go_to(movie)
    redirect_to movie_path(movie)
  end

  def get_info(movie, links, title_fr)
    api_key = ENV["TMDB_KEY"]
    url_for_id = URI.encode("https://api.themoviedb.org/3/search/movie?api_key=#{api_key}&language=en-US&query=#{movie}&page=1&include_adult=false")
    html_file_for_id = open(url_for_id).read
    html_doc_for_id = JSON.parse(html_file_for_id)
    tmdb_id = html_doc_for_id["results"][0]["id"]

    image_url_base = "https://image.tmdb.org/t/p/w500"

    url_for_info = URI.encode("https://api.themoviedb.org/3/movie/#{tmdb_id}?api_key=#{api_key}&language=en-US")
    html_file_for_info = open(url_for_info).read
    html_doc_for_info = JSON.parse(html_file_for_info)

    url_for_credits = "https://api.themoviedb.org/3/movie/#{tmdb_id}/credits?api_key=#{api_key}"
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
    urls = links
    title_fr = title_fr
    @movie = Movie.create(title: title, synopsis: synopsis, date: date, duration: duration, rating: rating, director: director, photo_url: image, cast: cast, urls: urls, title_fr: title_fr)
  end
end
