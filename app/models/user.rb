class User < ActiveRecord::Base
  include Logable

  TEMP_EMAIL = 'change@me.com'
  TEMP_EMAIL_REGEX = /change@me.com/

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
  has_many :groups, class_name: 'Group', foreign_key: 'user_id'
  has_many :viwed_articles, through: :views, source: :article
  has_many :views, foreign_key: "viewer_id",
                                   class_name:  "View",
                                   dependent:   :destroy
  has_many :refered_logs, class_name: 'Log', foreign_key: 'owner_id'
  validates :first_name, presence: true, length: {in: 2..30}
  validates :last_name, presence: true, length: {in: 2..30}


  def fullname
    return "#{self.first_name} #{self.last_name}"
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

  def view?(article)
    views.find_by(article_id: article.id)
  end

  def view!(article)
    views.create!(article_id: article.id)
  end

  def user
    if user
      user
    else
      "Someone"
    end
  end

  def self.find_for_oauth(auth, signed_in_resource = nil)

    identity = Identity.find_for_oauth(auth)
    user = identity.user
    if user.nil?
      user = User.where(:email => auth.info.email).first if auth.info.email
      if user.nil?
        user = User.new(
          first_name: auth.extra.raw_info.first_name,
          last_name: auth.extra.raw_info.last_name,
          #username: auth.info.nickname || auth.uid,
          email: auth.info.email.blank? ? TEMP_EMAIL : auth.info.email,
          password: Devise.friendly_token[0,20]
        )
        user.save!
      end

      if identity.user != user
        identity.user = user
        identity.save!
      end
    end
    user
  end

  def age
    now = Time.now.utc.to_date
    now.year - self.born_date.year - (born_date.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  def to_param
    username = self.fullname.gsub(' ','_').downcase
    if User.where(first_name: self.first_name).first == self
      "#{username}"
    else
      "#{username}_#{self.id}"
    end
  end

  def online?
    updated_at > 10.minutes.ago
  end

  def gender
    self.sex ? 'male' : 'female'
  end

  def self.search(search)
    if search
      self.where('lower(first_name) LIKE ? OR lower(last_name) LIKE ?', "%#{search}%", "%#{search}%")
    else
      self.order(updated_at: :desc)
    end
  end

  def has_new_logs?
    Log.all.each do |log|
      p log
      if log.get_recipient == self && !log.viewed
        return true
      end
    end
    false
  end

  def read_news!
    Log.all.each do |log|
      if (log.get_recipient == self) && (!log.viewed)
        log.update_column(:viewed, true)
      end
    end
  end

end
