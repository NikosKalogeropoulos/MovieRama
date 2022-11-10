class MoviesController < ApplicationController
   before_action :only_logged_in_user_can_create_movie, only: [:create, :new]

    def index
        @movies = Movie.all.includes(:user)
    end

    def show
        @movie = Movie.find_by(id: params[:id])
        if not @movie.nil?
            render :show
        else
            flash[:errors] = ["That movie doesn't exist"]
            redirect_to movies_url
        end

    end

    def new
        @movie = Movie.new
    end

    def create
        @movie = Movie.create(movie_params)
        @movie.user_id = current_user.id
        if @movie.save
            redirect_to movie_url(@movie)
        else
            flash[:errors] = @movie.errors.full_messages
            render :new
        end
    end

    def only_logged_in_user_can_create_movie
        redirect_back(fallback_location: movies_url) unless logged_in?

    end

    private

    def movie_params
        params.require(:movie).permit(:title, :description)
    end
end