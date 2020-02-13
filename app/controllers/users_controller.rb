class UsersController < ApplicationController

    before_action :authorized, except: [:new, :create]

    def new
        @user = User.new
        @errors = flash[:errors]
    end

    def create 
        @user = User.new(user_params)
        if @user.valid?
            @user.save
            session[:user_id] = @user.id
            redirect_to profile_path
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to new_user_path
        end
    end

    def show
        @user = User.find(params[:id])
        if @user == current_user
            redirect_to profile_path
        end
    end

    def profile
        @user = current_user
    end

    def index
        array = User.all.sort_by{|u| u.lifetime_points}
        @users = array.reverse
    end

    def edit
        @user = current_user
        @errors = flash[:errors]
    end

    def update
        @user = User.find(params[:id])
        @user.update(user_params)
        if @user.valid?
            redirect_to profile_path
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to edit_profile_path
        end
    end
    
    private

    def user_params
        params.require(:user).permit(:user_name, :password, :blurb)
    end
end
