class Comment < ActiveRecord::Base
  include Logable

  belongs_to :article
  belongs_to :user

  validates :content, presence: true
  validates :content, length: {maximum: 255}

  def return_created_at_as_nice_string
    self.created_at.strftime("%d %B %Y.")
  end

  def cut_content
    if self.content.length > 20
      return "#{self.content[0..20]}..."
    else
      return self.content
    end
  end

  def my_article
    if self.article
      return self.article.theme
    else
      return "Deleted article"
    end
  end

  def to_s
    self.content
  end
end
