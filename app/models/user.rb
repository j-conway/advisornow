class User < ActiveRecord::Base
  has_many :created_consults, :foreign_key => :creator_id, :class_name => 'Consult'
  has_many :cust_consults, :foreign_key => :customer_id, :class_name => 'Consult'
  has_many :ds_consults, :foreign_key => :datascientist_id, :class_name => 'Consult'
  has_many :consult_memberships
  has_many :consults, :through => :consult_memberships
  has_many :meeting_memberships
  has_many :meetings, :through => :meeting_memberships
  belongs_to :company
  
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def self.datascientists
    where(datascientist: true)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end