class Meeting < ActiveRecord::Base
	belongs_to :consult
	has_many :meeting_memberships
    has_many :meeting_members, :through => :meeting_memberships, :source => :user
    validates :description, presence: true, length: { maximum: 150 }
    validates :consult_id, presence: true
end
