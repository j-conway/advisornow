class ConsultMembership < ActiveRecord::Base
	belongs_to :user
	belongs_to :consult
	validates :user_id, presence: true
	validates :consult_id, presence: true
end
