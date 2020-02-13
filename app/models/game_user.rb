class GameUser < ApplicationRecord
    belongs_to :game
    belongs_to :user

    def increase_score_by(value)
        new_score = self.score + value
        self.update(score: new_score)
        self.user.increase_lp_by(value)
    end
    def increment_turn
        new_turn = self.turn + 1
        self.update(turn: new_turn)
    end
end
