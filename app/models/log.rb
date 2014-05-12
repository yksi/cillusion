class Log < ActiveRecord::Base

  belongs_to :logable
  belongs_to :user

  def logable
    self.logable_type.titleize.constantize.find(self.logable_id)
  end

  def set_message
    result = case self.logable_type.downcase
      when 'article' then 'You have new article view'
      when 'relationship' then 'You have new follower'
      when 'comment' then 'left comment on your article'
      when 'message' then 'You have recieved private message'
    end
  end

  def get_recipient
    result = case self.logable
      when Relationship then logable.followed
      when View then logable.article.user
      when Comment then logable.article.user
    end
  end

  def to_s
    set_message
  end
end