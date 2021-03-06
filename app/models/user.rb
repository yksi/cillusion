class User < ActiveRecord::Base
  include Logable

  TEMP_EMAIL = 'change@me.com'
  TEMP_EMAIL_REGEX = /change@me.com/

  before_create :set_uid

  mount_uploader :avatar, AvatarUploader
  mount_uploader :cover, CoverUploader
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
  validates :first_name, presence: true, length: { in: 2..30 }
  validates :last_name, presence: true, length: { in: 2..30 }
  validate :uid, length: { in: 4..20 }, uniqueness: { case_sensitive: false }

  def fullname
    "#{self.first_name} #{self.last_name}"
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
    if uid.nil?
      "id#{id}"
    else
      uid
    end
  end

  def online?
    updated_at > 10.minutes.ago
  end

  def is_admin?
    role == 3
  end

  def gender
    self.sex ? 'male' : 'female'
  end

  def self.search(search)
    if search
      inCase = search.split(' ')
      if inCase.count > 1
        self.where('lower(first_name) LIKE ? OR lower(last_name) LIKE ? OR lower(first_name) LIKE ? OR lower(last_name) LIKE ?', "%#{inCase[0]}%", "%#{inCase[1]}%", "%#{inCase[1]}%", "%#{inCase[0]}%")
      else
        self.where('lower(first_name) LIKE ? OR lower(last_name) LIKE ?', "%#{search}%", "%#{search}%")
      end
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

  def unread_messages
    count = 0
    recieved_messages.each do |m|
      if !m.read
        count += 1
      end
    end
    count
  end

  private

  def set_uid
    self.uid = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
end
