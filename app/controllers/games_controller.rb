class GamesController < ApplicationController

    def welcome
        if Game.all.count == 0
            @game = Game.create(category_1: "empty", category_2: "empty", category_3: "empty", category_4: "empty", category_5: "empty")
        else
            @game = Game.find_by(id: 1)
        end
        if session[:user_id]
            @user = current_user
        end
    end

    def new_game
        GameUser.delete_all
        @game = Game.find(params[:id])
        @game.update(category_1: "empty", category_2: "empty", category_3: "empty", category_4: "empty", category_5: "empty")
        existing_gu = GameUser.all.map{|gu| gu.user}
        @users = []
        User.all.each do |u|
            if !existing_gu.include?(u)
                @users << u
            end
        end
    end

    def game_user
        @game = Game.find(params[:id])
        u_id = game_user_params(:user_id)[:user_id]
        GameUser.create(game_id: @game.id, user_id: u_id, score: 0, turn: 1)
        redirect_to new_game_path(@game)
    end

    def categories
        @game = Game.find(params[:id])
        gu = GameUser.all.min_by{|u| u.turn}
        @user = gu.user
        @turn = gu.turn
        @score = gu.score
        @categories = []
        @categories << @game.category_1
        @categories << @game.category_2
        @categories << @game.category_3
        @categories << @game.category_4
        @categories << @game.category_5
        @difficulties = ["Easy", "Medium", "Hard"]
    end

    def question
        @game = Game.find(params[:id])
        @user = GameUser.all.min_by{|u| u.turn}
        
    end

    def guess
        #guess = params


    
    private

    def game_user_params(*args)
        params.permit(*args)
    end
        
end
