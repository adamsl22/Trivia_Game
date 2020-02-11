class UsersController < ApplicationController

    before_action :authorized, except: [:new, :create]

    def new
        @user = User.new
    end

    def create 
        @user = User.create(user_params)
        session[:user_id] = @user.id
        redirect_to user_path(@user)
    end

    def show 
        @user = current_user
    end
    
    private

    def user_params
        params.require(:user).permit(:user_name, :password)
    end
end
