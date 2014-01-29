class Meeting < ActiveRecord::Base
	belongs_to :consult
	has_many :meeting_memberships
    has_many :meeting_members, :through => :meeting_memberships, :source => :user
end
