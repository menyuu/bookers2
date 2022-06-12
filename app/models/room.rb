class Room < ApplicationRecord

  has_many :entries, dependent: :destroy
  # has_many :user, through: :entries
  has_many :messages,dependent: :destroy

end
