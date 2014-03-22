class Article < ActiveRecord::Base
  mount_uploader :photo, ArticlePhotoUploader

  belongs_to :user
  has_many :comments, class_name: 'Comment', foreign_key: 'article_id'  

  validates :theme, presence: true

  extend FriendlyId
  friendly_id :theme 

  def print_info
    p "#{self.theme} - #{self.content} at #{self.date.strftime('%d %B %Y')} by #{User.find(self.user_id)}"
  end

  def self.search(search)
    if search
      self.find(:all, conditions: ['lower(theme) LIKE ?', "%#{search}%"])
    else
      self.find(:all)
    end
  end

  def to_param
    "#{self.id} #{self.theme}".parameterize
  end

  def return_created_at_as_nice_string
    self.created_at.strftime("%d %B %Y.")
  end

end
