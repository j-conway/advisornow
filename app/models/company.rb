class Company < ActiveRecord::Base
	has_many :users
	has_many :admins, -> { where admin: true }, class_name: 'User'
	has_many :entitled_users, -> { where entitled: true }, class_name: 'User'
	validates :name, presence: true, length: { maximum: 50 }
	validates :entitlements,  presence: true
end
