class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user

  validates :content, presence: true

  def return_created_at_as_nice_string
    self.created_at.strftime("%d %B %Y.")
  end

  #attr_accessible :article, :user, :content
end
