class Api::V1::MovieController < ApplicationController
  def index
    movies = MovieSerializer.new(Movie.all).serialized_json
    render json: movies
  end

  def create
    movie = Movie.new(permited_attributes)
    if movie.save
      render json: MovieSerializer.new(movie).serialized_json
    else
      respond_with_errors(movie)
    end
  end

  def show
    movie = Movie.find(params[:id])
    render json: MovieSerializer.new(movie).serialized_json
  end

  def update
    movie = Movie.find(params[:id])
    if movie.update(permited_attributes)
      render json: MovieSerializer.new(movie).serialized_json
    else
      respond_with_errors(movie)
    end
  end

  def destroy
    movie = Movie.find(params[:id])
    movie.destroy
    head :no_content
  end


  private

  def permited_attributes
    params.permit([:title, :release_year])
  end
end
