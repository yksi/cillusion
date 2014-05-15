class Article < ActiveRecord::Base
  include Logable

  mount_uploader :photo, ArticlePhotoUploader

  belongs_to :user
  belongs_to :group
  has_many :comments, class_name: 'Comment', foreign_key: 'article_id'
  has_many :views, foreign_key: "article_id", dependent: :destroy
  has_many :viewers, through: :views

  validates :category, presence: true
  validates :theme, presence: true
  validates :content, presence: truez

  extend FriendlyId
  friendly_id :theme

  def print_info
    p "#{self.theme} - #{self.content} at #{self.date.strftime('%d %B %Y')} by #{User.find(self.user_id)}"
  end

  def self.search(search)
    if search
      self.where('lower(theme) LIKE ?', "%#{search}%")
    else
      self.all
    end
  end

  def to_param
    "#{self.id} #{self.theme} #{self.user_id}".parameterize
  end

  def return_created_at_as_nice_string
    self.created_at.strftime("%d %B %Y.")
  end

end
