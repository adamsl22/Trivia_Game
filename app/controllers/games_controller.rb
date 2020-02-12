class GamesController < ApplicationController

    def welcome
        GameUser.delete_all
        if Game.all.count == 0
            @game = Game.create(category_1: Game.cat_1, category_2: Game.cat_2, category_3: Game.cat_3, category_4: Game.cat_4, category_5: Game.cat_5)
        else
            @game = Game.find_by(id: 1)
        end
        if session[:user_id]
            @user = current_user
        end
    end

    def new_game
        @game = Game.find(params[:id])
        @game.update(category_1: Game.cat_1, category_2: Game.cat_2, category_3: Game.cat_3, category_4: Game.cat_4, category_5: Game.cat_5)
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
    end

    def api_request
        @game = Game.find(params[:id])
        cat_string = api_params(:category)[:category]
        cat = Game.cat_to_num(cat_string)
        dif = api_params(:difficulty)[:difficulty]
        q_hash = OpenTDB.seach_question(cat, dif)
        
    end


    def question
        @game = Game.find(params[:id])
        @user = GameUser.all.min_by{|u| u.turn}
        
    end
        #guess = params


    
    private

    def game_user_params(*args)
        params.permit(*args)
    end
    
    def api_params(*args)
        params.permit(*args)
    end
        
end
