class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  before_create :generate_authentication_token

  def set_default_role
    self.role ||= :user
  end

  def generate_authentication_token
    loop do
      self.authentication_token = SecureRandom.urlsafe_base64(48)
      break unless User.find_by(authentication_token: authentication_token)
    end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
