class Company < ActiveRecord::Base
	has_many :users
	validates :name, presence: true, length: { maximum: 50 }
	validates :entitlements,  presence: true
end
