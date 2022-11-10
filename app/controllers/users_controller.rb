class UsersController < ApplicationController

    def show

    end

    def new
    end

    def create
        user = User.new(user_params)
        if user.save
            redirect_to new_user_url
        else 
            flash.now[:errors] = user.errors.full_messages
            redirect_to new_user_url
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end