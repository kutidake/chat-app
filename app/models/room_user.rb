class RoomUser < ApplicationRecord
  belongs_to :room
  belongs_to :yser
end