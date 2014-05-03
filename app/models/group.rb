class Group < ActiveRecord::Base
  belongs_to :user
  has_many :articles, class_name: "Article", foreign_key: "group_id"

  validates :name, presence: true
end
