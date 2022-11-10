class SessionsController < ApplicationController

    def new

    end

    def create
        user = User.find_by_credentials(params[:user][:username], params[:user][:password])
        if user.nil?
            flash[:errors] = ["Credentials were wrong"]
            render :new
        else
            user.reset_session_token!
            login!(user)
            redirect_to movies_url
        end
    end

    def destroy
        if !current_user.nil?
            current_user.reset_session_token!
            session[:session_token] = nil
            redirect_to new_session_url
        end
    end
end