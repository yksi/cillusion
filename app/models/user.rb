class User < ActiveRecord::Base

  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]

  has_many :user_articles, class_name: 'Article', foreign_key: 'user_id'
  has_many :comments, class_name: 'Comment', foreign_key: 'user_id'
  has_many :followed_users, through: :relationships, source: :followed
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships
  has_many :recieved_messages, class_name: 'Message', foreign_key: 'recipient_id'
  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'

  validates :first_name, presence: true, length: {in: 2..30}
  validates :last_name, presence: true, length: {in: 2..30}


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

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
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
