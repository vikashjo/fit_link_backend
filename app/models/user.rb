class User < ApplicationRecord
    has_secure_password 
    validates :email, presence: true, uniqueness: true
    validates :name, presence: true
    validates :weight, presence: true
    validates :height, presence: true
end
