class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  devise :omniauthable, :omniauth_providers => [:facebook]
  
  has_many :user_articles, class_name: 'Article', foreign_key: 'user_id'
  has_many :comments, class_name: 'Comment', foreign_key: 'user_id'  

  validates :first_name, presence: true, length: {in: 2..30}
  validates :last_name, presence: true, length: {in: 2..30}

  def fullname
    return "#{self.first_name} #{self.last_name}"
  end

  def get_short_info_as_string
    p "#{self.fullname}(#{self.email})"
    "#{self.fullname}(#{self.email})"
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

 


end
