class User < ActiveRecord::Base

  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]
  
  has_many :user_articles, class_name: 'Article', foreign_key: 'user_id'
  has_many :comments, class_name: 'Comment', foreign_key: 'user_id'

  validates :first_name, presence: true, length: {in: 2..30}
  validates :last_name, presence: true, length: {in: 2..30}

  acts_as_followable
  acts_as_follower

  def fullname
    return "#{self.first_name} #{self.last_name}"
  end

  def get_short_info_as_string
    p "#{self.fullname}(#{self.email})"
  end

  def get_count
    return self.user_articles.count
  end

  def is_all_fields_filled?
    if first_name == nil || last_name == nil || age == nil || sex == nil || email == nil || hometown == nil
      false
    else
      true
    end
  end

  def self.find_for_facebook_oauth(auth)
  where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name   # assuming the user model has a name
      user.last_name = auth.info.last_name
      user.avatar = auth.info.image # assuming the user model has an image
    end
  end

end
