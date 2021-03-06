
class MoviesController < ApplicationController
  def index
    @movies = Movie.now_playing
    if params[:search]
      @movies = Movie.search(params[:search])
    else
      @movies = Movie.now_playing
    end
  end

  def show
    begin
      @movie = Movie.get_by_id(params[:id])
    rescue
      redirect_to '/movies'
    end
  end

end
