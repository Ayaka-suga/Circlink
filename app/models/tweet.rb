class Tweet < ApplicationRecord
    belongs_to :user
    belongs_to :group , optional: true
    has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user
    has_one_attached :image
end

