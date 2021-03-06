class MoviesController < ApplicationController
  before_action :image_path, only: %i(index search)

  def index
    @movies = movie_service.popular
  end

  def show
    @movie = MoviePresenter.new(movie_detail).data
    @movie[:image_path] = "#{image_path}/w300_and_h450_bestv2#{@movie.poster_path}"
    render json: @movie
  end

  def search
    @movies = movie_service.find(params[:q])
    render json: @movies
  end

  private

  def movie_detail
    movie_service.movie_detail(params['id'])
  end

  def image_path
    @image_path ||= movie_service.configuration.base_url
  end

  def movie_service
    @movie_service ||= MovieDbService.new
  end
end
