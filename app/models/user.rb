class User < ApplicationRecord
    has_secure_password
    
    has_many :game_users
    has_many :games, through: :game_users

    validates :user_name, presence: {message: "error: You must make a username."}, uniqueness: {message: "error: That username is already in use."}
    validates :password, presence: {message: "error: You must make a password."}

    def increase_lp_by(value)
        new_lp = self.lifetime_points + value
        self.update_attribute(:lifetime_points, new_lp)
        self.increment_level
    end
    def increment_level
        if self.lifetime_points > 1000 + 200 * 2 ** self.level
            new_level = self.level + 1
            self.update_attribute(:level, new_level)
        end
    end
end
