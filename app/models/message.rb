class Message < ActiveRecord::Base
  belongs_to :sender
  belongs_to :recipient

  validates :theme, presence: true
end
