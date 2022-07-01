class Book < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1,
  }, presence: true

  is_impressionable counter_cache: true

  belongs_to :user

  has_many :favorites, dependent: :destroy

  has_many :book_comments, dependent: :destroy

  has_many :book_tags, dependent: :destroy
  has_many :tags, through: :book_tags

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.looks(word, search)
    case search
    when "perfect"
      Book.where("title LIKE ?", "#{word}").includes(:user ,user: {profile_image_attachment: :blob})
    when "forward"
      Book.where("title LIKE ?", "#{word}%").includes(:user ,user: {profile_image_attachment: :blob})
    when "backward"
      Book.where("title LIKE ?", "%#{word}").includes(:user ,user: {profile_image_attachment: :blob})
    when "partial"
      Book.where("title LIKE?", "%#{word}%").includes(:user ,user: {profile_image_attachment: :blob})
    end
  end

  def save_tag(tag_list)
    unless tags.nil?
      book_tags_records = BookTag.where(book_id: id)
      book_tags_records.destroy_all
    end

    tag_list.each do |tag|
      inspected_tag = Tag.where(tag_name: tag).first_or_create
      tags << inspected_tag
    end
  end

  # scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  # scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
  scope :created_this_week, -> { where(created_at: Time.current.beginning_of_week..Time.zone.now.end_of_day) }
  scope :created_last_week, -> { where(created_at: (Time.current - 1.week).beginning_of_week..(Time.current - 1.week).end_of_week) }

  scope :created_days, -> (n) { where(created_at: n.days.ago.all_day) }

  def self.past_week_count
    (0..6).map { |n| created_days(n).count }.reverse
  end

end
