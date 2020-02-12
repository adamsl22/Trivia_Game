class Game < ApplicationRecord
    has_many :game_users
    has_many :users, through: :game_users

    validates :target_points, numericality: {greater_than_or_equal_to: 100, message: "error: The target score must be at least 100 (the minimum number of points for a question)."}

    def winning_player
        self.game_users.max_by{|gu| gu.score}
    end

    def check_for_win(player)
        if self.winning_player.score >= self.target_points && self.game_users[-1] == player
            return true
        else
            return false
        end
    end

    def self.question_category(question_hash)
        question_hash[0]["category"]
    end
    def self.points_value(question_hash)
        difficulty = question_hash[0]["difficulty"].capitalize
        if difficulty == "Easy"
            value = 100
        elsif difficulty == "Medium"
            value = 300
        elsif difficulty == "Hard"
            value = 500
        end
        return value
    end
    def self.question_text(question_hash)
        question_hash[0]["question"]
    end
    def self.correct_answer(question_hash)
        question_hash[0]["correct_answer"]
    end
    def self.incorrect_answer1(question_hash)
        question_hash[0]["incorrect_answers"][0]
    end
    def self.incorrect_answer2(question_hash)
        question_hash[0]["incorrect_answers"][1]
    end
    def self.incorrect_answer3(question_hash)
        question_hash[0]["incorrect_answers"][2]
    end

    def self.cat_1
        #Screen and Stage
        arr = [11,13,14,26,32]
        c1 = arr.sample
        if c1 == 11
            cat_1 = "Entertainment: Film"
        elsif c1 == 13
            cat_1 = "Entertainment: Musicals & Theatres"
        elsif c1 == 14
            cat_1 = "Entertainment: Television"
        elsif c1 == 26
            cat_1 = "Celebrities"
        elsif c1 == 32
            cat_1 = "Entertainment: Cartoon & Animations"
        end
        return cat_1
    end
    def self.cat_2
        #Books and Games
        arr = [10,15,16,29,31]
        c2 = arr.sample
        if c2 == 10
            cat_2 = "Entertainment: Books"
        elsif c2 == 15
            cat_2 = "Entertainment: Video Games"
        elsif c2 == 16
            cat_2 = "Entertainment: Board Games"
        elsif c2 == 29
            cat_2 = "Entertainment: Comics"
        elsif c2 == 31
            cat_2 = "Entertainment: Japanese Anime & Manga"
        end
        return cat_2
    end
    def self.cat_3
        #Science
        arr = [17,18,19,28,30]
        c3 = arr.sample
        if c3 == 17
            cat_3 = "Science & Nature"
        elsif c3 == 18
            cat_3 = "Science: Computers"
        elsif c3 == 19
            cat_3 = "Science: Mathematics"
        elsif c3 == 28
            cat_3 = "Vehicles"
        elsif c3 == 30
            cat_3 = "Science: Gadgets"
        end
        return cat_3
    end
    def self.cat_4
        #Social Studies
        arr = [20,22,23,24]
        c4 = arr.sample
        if c4 == 20
            cat_4 = "Mythology"
        elsif c4 == 22
            cat_4 = "Geography"
        elsif c4 == 23
            cat_4 = "History"
        elsif c4 == 24
            cat_4 = "Politics"
        end
        return cat_4
    end
    def self.cat_5
        #Misc
        arr = [9,12,21,25,27]
        c5 = arr.sample
        if c5 == 9
            cat_5 = "General Knowledge"
        elsif c5 == 12
            cat_5 = "Entertainment: Music"
        elsif c5 == 21
            cat_5 = "Sports"
        elsif c5 == 25
            cat_5 = "Art"
        elsif c5 == 27
            cat_5 = "Animals"
        end
        return cat_5
    end

    def self.cat_to_num(cat)
        if cat == "Entertainment: Film"
            num = 11
        elsif cat == "Entertainment: Musicals & Theatres"
            num = 13
        elsif cat == "Entertainment: Television"
            num = 14
        elsif cat == "Celebrities"
            num = 26
        elsif cat == "Entertainment: Cartoon & Animations"
            num = 32
        elsif cat == "Entertainment: Books"
            num = 10
        elsif cat == "Entertainment: Video Games"
            num = 15
        elsif cat == "Entertainment: Board Games"
            num = 16
        elsif cat == "Entertainment: Comics"
            num = 29
        elsif cat == "Entertainment: Japanese Anime & Manga"
            num = 31
        elsif cat == "Science & Nature"
            num = 17
        elsif cat == "Science: Computers"
            num = 18
        elsif cat == "Science: Mathematics"
            num = 19
        elsif cat == "Vehicles"
            num = 28
        elsif cat == "Science: Gadgets"
            num = 30
        elsif cat == "Mythology"
            num = 20
        elsif cat == "Geography"
            num = 22
        elsif cat == "History"
            num = 23
        elsif cat == "Politics"
            num = 24
        elsif cat == "General Knowledge"
            num = 9
        elsif cat == "Entertainment: Music"
            num = 12
        elsif cat == "Sports"
            num = 21
        elsif cat == "Art"
            num = 25
        elsif cat == "Animals"
            num = 27
        end
        return num
    end

end
