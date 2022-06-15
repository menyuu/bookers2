class BookTag < ApplicationRecord
  validates :book_id, presence: true
  validates :tag_id, presence: true

  belongs_to :book
  belongs_to :tag
end
