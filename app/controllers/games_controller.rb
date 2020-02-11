class GamesController < ApplicationController
    def welcome
        if Game.all.count == 0
            @game = Game.create(turn: 1, category_1: "empty", category_2: "empty", category_3: "empty", category_4: "empty", category_5: "empty")
        else
            @game = Game.find_by(id: 1)
        end
    end


    def new_game
        GameUser.delete_all
        @game = Game.find(params[:id])
        @game.update(turn: 1, category_1: "empty", category_2: "empty", category_3: "empty", category_4: "empty", category_5: "empty")
        existing_gu = GameUser.all.map{|gu| gu.user}
        @users = []
        User.all.each do |u|
            if !gu.include?(existing_gu)
                @users << u
            end
        end
    end


    def game_user
        @game = Game.find(params[:id])
        u_id = game_user_params(:user_id)[:user_id]
        GameUser.create(game_id: @game.id, user_id: u_id, score: 0)
        redirect_to new_game_path(@game)
    end


    
    private

    def game_user_params(*args)
        params.require(:game_user).permit(*args)
    end
        
end
