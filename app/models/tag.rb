class Tag < ApplicationRecord

  validates :tag_name,uniqueness: true

  has_many :book_tags, dependent: :destroy
  # , foreign_key: 'tag_id'
  has_many :books, through: :books_tag
end
