class MoviesController < ApplicationController
   before_action :only_logged_in_user_can_create_movie_and_react, only: [:create, :new, :like, :hate]
   before_action :user_cant_react_to_his_movies, only: [:like, :hate]
   after_action :reset_reaction, only: [:like, :hate]

    def index
        if params[:user_id]
            @user = User.find_by(id: params[:user_id])
            render_user_movies_with_filters(@user)
        else
           render_movies_with_filters 
        end
    end

    def render_user_movies_with_filters(user)
        case params[:filter]
            when "date"
                @movies = order_movies_by_creation_date.where("movies.user_id = #{user.id}")
            when "likes"
                @movies = order_movies_by_number_of_likes.where("movies.user_id = #{user.id}")
            when "hates"
                @movies = order_movies_by_number_of_hates.where("movies.user_id = #{user.id}")
            else
                @movies = user.movies
            end
    end

    def render_movies_with_filters
        case params[:filter]
            when "date"
                @movies = order_movies_by_creation_date
            when "likes"
                @movies = order_movies_by_number_of_likes
            when "hates"
                @movies = order_movies_by_number_of_hates
            else
                @movies = Movie.all.includes(:user)
            end
    end

    def order_movies_by_creation_date
        Movie.order("created_at DESC").includes(:user)
    end

    def order_movies_by_number_of_likes
        Movie
        .joins(:reactions)
        .select("
            movies.*, 
            sum(case when reactions.ttype = 'LIKE' then 1 else 0 end) as c")
        .order("c DESC")
        .group('movies.id').includes(:user)
    end

    def order_movies_by_number_of_hates
        Movie
        .joins(:reactions)
        .select("movies.*, sum(case when reactions.ttype='HATE' then 1 else 0 end) as c")
        .order("c DESC")
        .group('movies.id').includes(:user)
    end

    
    def user_cant_react_to_his_movies
        movie = Movie.find_by(id: params[:id])
        if movie.nil? || movie.user == current_user
            redirect_to movies_url if movie.user == current_user
        end
    end


    def new
        @movie = Movie.new
    end

    def create
        @movie = Movie.create(movie_params)
        @movie.user_id = current_user.id
        if @movie.save
            redirect_to movies_url
        else
            flash.now[:errors] = @movie.errors.full_messages
            render :new
        end
    end

    def react(reaction_type)
        if user_already_reacted?
            update_reaction_type(reaction_type)
        else
            create_new_reaction(reaction_type)
        end
    end

    def like
        react(Reaction::LIKE)
    end

    def hate
        react(Reaction::HATE)
    end

    private

    def update_reaction_type(reaction_type)
        if reaction.ttype == reaction_type
            reaction.destroy
            redirect_back(fallback_location: movies_url) 
        else
            reaction.ttype = reaction_type
            if reaction.save
                redirect_back(fallback_location: movies_url) 
            else
                flash.now[:errors] = reaction.errors.full_messages
                render movies_url
            end
        end
    end

    def user_already_reacted?
        !reaction.nil?
    end

    def reaction
        @reaction ||= Reaction.find_by(user_id: current_user.id, movie_id: params[:id])
    end

    def reset_reaction
        @reaction = nil
    end

    def create_new_reaction(reaction_type)
        @reaction = Reaction.new(user_id: current_user.id, movie_id: params[:id], ttype: reaction_type)
        if @reaction.save
            redirect_back(fallback_location: movies_url) 
        else
            flash.now[:errors] = @reaction.errors.full_messages
            render movies_url
        end
    end

    def only_logged_in_user_can_create_movie_and_react
        redirect_back(fallback_location: movies_url) unless logged_in?
    end

    def movie_params
        params.require(:movie).permit(:title, :description)
    end
end