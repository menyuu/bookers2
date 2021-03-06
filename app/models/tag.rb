class Tag < ApplicationRecord
  validates :tag_name, uniqueness: true

  has_many :book_tags, dependent: :destroy
  has_many :books, through: :book_tags
end
