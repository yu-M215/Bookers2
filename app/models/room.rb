class Room < ApplicationRecord
  has_many :users, through: :user_room
  has_many :user_rooms
  has_many :messages
end
