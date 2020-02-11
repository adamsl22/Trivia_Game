class SessionController < ApplicationController
    def new 
    end

    def create 
        @user = User.find_by(user_name: params)
        if @user && @user.authenticate(params[:password])
            session[:id] = @user.id
        else
            flash[:errors] << "Username or Password Incorrect"
            redirect_to new_session_path
        end
    end

    def destroy
        session[:user_id] = nil
    end

end
