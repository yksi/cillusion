class View < ActiveRecord::Base
  include Logable

  belongs_to :viewer, class_name: "User"
  belongs_to :article, class_name: "Article"
  validates :viewer_id, presence: true
  validates :article_id, presence: true
end
