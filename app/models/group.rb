class Group < ActiveRecord::Base
  belongs_to :user
  has_many :articles, class_name: "Article", foreign_key: "group_id"

  validates :name, presence: true

  def cover_photo
    articles.order(created_at: :asc).each do |article|
      if article.photo?
        return article.photo.small.url
      end
    end
    nil
  end

  def total_views
    views = 0
    articles.order(created_at: :asc).each do |article|
      views += article.views.count
    end
    views
  end

  def self.search(search)
    if search
      self.where('lower(name) LIKE ?', "%#{search}%")
    else
      self.all
    end
  end
end
