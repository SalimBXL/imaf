class User < ApplicationRecord
    
    validates_presence_of :username, presence: true
    validates :username, uniqueness: true

    validates_presence_of :password, presence: true
    validates :password, confirmation: true

    validates_presence_of :email, presence: true
    validates :email, uniqueness: true
    validates :email, confirmation: true

    has_many :friendships
    has_many :friends, through: :friendships
end
