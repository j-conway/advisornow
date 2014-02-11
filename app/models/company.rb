class Company < ActiveRecord::Base
	has_many :users
	has_many :admins, -> { where admin: true }, class_name: 'User'
	has_many :entitled_users, -> { where entitled: true }, class_name: 'User'
    has_many :consults, :through => :users, :source => :cust_consults
	validates :name, presence: true, length: { maximum: 50 }
	validates :entitlements,  presence: true
	

	def self.admins
      self.users where(company_admin: true)
    end
end