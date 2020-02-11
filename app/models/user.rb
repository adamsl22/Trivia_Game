class User < ApplicationRecord
    has_secure_password
    
    has_many :game_users
    has_many :games, through: :game_users

    validates :user_name, presence: {message: "error: You must make a username."}, uniqueness: {message: "error: That username is already in use."}
    validates :password, presence: {message: "error: You must make a password."}

end
