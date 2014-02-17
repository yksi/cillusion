class Article < ActiveRecord::Base

  belongs_to :user
  has_many :comments, class_name: 'Comment', foreign_key: 'article_id'  

  validates :theme, presence: true
  validates :date, presence: true

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

end
