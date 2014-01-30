class Consult < ActiveRecord::Base
	belongs_to :creator, :class_name => 'User'
	belongs_to :customer, :class_name => 'User'
	belongs_to :datascientist, :class_name => 'User'
    has_one :company, :through => :customer
	has_many :consult_memberships
  	has_many :consult_members, :through => :consult_memberships, :source => :user
  	has_many :meetings
end
