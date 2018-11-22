class Api::V1::MoviesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    movies = MovieSerializer.new(Movie.all).serialized_json
    render json: movies
  end

  def create
    movie = Movie.new(permited_attributes)
    if movie.save
      render json: serialize_movie(movie)
    else
      respond_with_errors(movie)
    end
  end

  def show
    render json: serialize_movie(movie)
  end

  def update
    if movie.update(permited_attributes)
      render json: serialize_movie(movie)
    else
      respond_with_errors(movie)
    end
  end

  def destroy
    movie.destroy
    head :no_content
  end

  def add_actor
    movie.casting.push(person)
    render json: serialize_movie(movie)
  end

  def remove_actor
    movie.casting.delete(person)
    render json: serialize_movie(movie)
  end

  def add_director
    movie.directors.push(person)
    render json: serialize_movie(movie)
  end

  def remove_director
    movie.directors.delete(person)
    render json: serialize_movie(movie)
  end

  def add_producer
    movie.producers.push(person)
    render json: serialize_movie(movie)
  end

  def remove_producer
    movie.producers.delete(person)
    render json: serialize_movie(movie)
  end

  private

  def permited_attributes
    params.permit([:title, :release_year])
  end

  def movie
    @movie ||= Movie.find(params[:id])
  end

  def person
    @person ||= Person.find(params[:person_id])
  end

  def serialize_movie(object)
    options = {}
    options[:include] = [:casting, :directors, :producers]
    MovieSerializer.new(object, options).serialized_json
  end
end
