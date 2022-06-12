class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, uniqueness: true, length: {in: 2..20}
  validates :introduction, length: {maximum: 50}

  has_many :books, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorited_books, through: :favorites, source: :book

  has_many :book_comments, dependent: :destroy

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  has_many :group_users
  has_many :groups, through: :group_users
  

  has_one_attached :profile_image

  def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
  end


  def follow(user)
    unless self == user
      relationships.create(followed_id: user)
    end
  end

  def unfollow(user)
    relationships.find_by(followed_id: user).destroy
  end

  def following?(user)
    followings.include?(user)
  end


  def self.looks(word, search)
    case search
      when "perfect"
        User.where("name LIKE ?", "#{word}")
      when "forward"
        User.where("name LIKE ?","#{word}%")
      when "backward"
        User.where("name LIKE ?", "%#{word}")
      when "partial"
        User.where("name LIKE?", "%#{word}%")
    end
  end

end