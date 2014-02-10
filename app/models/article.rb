class Article < ActiveRecord::Base
	belongs_to :user

  validates :theme, presence: true
  validates :date, presence: true

  def print_info
    p "#{self.theme} - #{self.content} at #{self.date.strftime('%d %B %Y')} by #{User.find(self.user_id)}"
    "#{self.theme} - #{self.content} at #{self.date.strftime('%d %B %Y')} by"
  end

end
