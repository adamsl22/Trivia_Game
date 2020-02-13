class GamesController < ApplicationController

    def welcome
        GameUser.delete_all
        if Game.all.count == 0
            @game = Game.create(category_1: Game.cat_1, category_2: Game.cat_2, category_3: Game.cat_3, category_4: Game.cat_4, category_5: Game.cat_5, target_points: 1500, token: "")
        else
            @game = Game.find_by(id: 1)
        end
        if session[:user_id]
            @user = current_user
        end
    end

    def new_game
        @game = Game.find(params[:id])
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

    def set_target_points
        @game = Game.find(params[:id])
        @errors = flash[:errors]
    end

    def update_tp
        @game = Game.find(params[:id])
        token = OpenTDB.new_session_key
        @game.update(category_1: Game.cat_1, category_2: Game.cat_2, category_3: Game.cat_3, category_4: Game.cat_4, category_5: Game.cat_5, target_points: game_params(:target_points)[:target_points], token: token)
        if @game.valid?
            redirect_to categories_path(@game)
        else
            flash[:errors] = @game.errors.full_messages
            redirect_to target_points_path(@game)
        end
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
        flash[:q_hash] = OpenTDB.search_question(cat, dif, @game.token)
        redirect_to question_path(@game)
    end

    def question
        @game = Game.find(params[:id])
        @gu = GameUser.all.min_by{|u| u.turn}
        @user = @gu.user
        @turn = @gu.turn
        @score = @gu.score
        q_hash = flash[:q_hash]
        if !q_hash
            redirect_to categories_path(@game)
        end
        @cat = Game.question_category(q_hash)
        @value = Game.points_value(q_hash)
        @question = Game.question_text(q_hash)
        @answers = [[Game.correct_answer(q_hash), @value], [Game.incorrect_answer1(q_hash), 0], [Game.incorrect_answer2(q_hash), 0], [Game.incorrect_answer3(q_hash), 0]]
    end

    def guess
        @game = Game.find(params[:id])
        value = guess_params(:correct)[:correct].to_i
        player = GameUser.all.min_by{|u| u.turn}
        player.increase_score_by(value)
        flash[:value] = value
        redirect_to result_path(@game)
    end

    def result
        @game = Game.find(params[:id])
        @value = flash[:value]
    end

    def end_turn
        @game = Game.find(params[:id])
        player = GameUser.all.min_by{|u| u.turn}
        player.increment_turn
        if @game.check_for_win(player) == true
            redirect_to winner_path(@game)
        else
            redirect_to categories_path(@game)
        end
    end

    def winner
        @game = Game.find(params[:id])
        winning_gu = @game.winning_player
        @winner = winning_gu.user.user_name
    end
    
    private

    def game_user_params(*args)
        params.permit(*args)
    end
    def game_params(*args)
        params.require(:game).permit(*args)
    end
    def api_params(*args)
        params.permit(*args)
    end
    def guess_params(*args)
        params.permit(*args)
    end
        
end
