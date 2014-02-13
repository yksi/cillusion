class Article < ActiveRecord::Base

  belongs_to :user
  has_many :comments, class_name: 'Comment', foreign_key: 'article_id'  

  validates :theme, presence: true
  validates :date, presence: true

  def print_info
    p "#{self.theme} - #{self.content} at #{self.date.strftime('%d %B %Y')} by #{User.find(self.user_id)}"
    "#{self.theme} - #{self.content} at #{self.date.strftime('%d %B %Y')} by"
  end

  def self.search(search)
    if search
      find(:all, conditions: ['theme LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

end
