class Book < ApplicationRecord

  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}

  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }, presence: true

  belongs_to :user

  has_many :favorites, dependent: :destroy

  has_many :book_comments, dependent: :destroy

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(word, search)
    case search
      when "perfect"
        Book.where("title LIKE ?", "#{word}")
      when "forward"
        Book.where("title LIKE ?","#{word}%")
      when "backward"
        Book.where("title LIKE ?", "%#{word}")
      when "partial"
        Book.where("title LIKE?", "%#{word}%")
    end
  end

end
