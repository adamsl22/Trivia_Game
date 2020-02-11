class SessionController < ApplicationController
    
    def new 
    end

    def create 
        @user = User.find_by(user_name: params[:user_name])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            flash[:errors] = "Username or Password Incorrect"
            redirect_to new_session_path
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to welcome_path
    end

end
