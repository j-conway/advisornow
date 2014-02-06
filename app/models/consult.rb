class Consult < ActiveRecord::Base
	belongs_to :creator, :class_name => 'User'
	belongs_to :customer, :class_name => 'User'
	belongs_to :datascientist, :class_name => 'User'
    has_one :company, :through => :customer
	has_many :consult_memberships
  	has_many :consult_members, :through => :consult_memberships, :source => :user
  	has_many :meetings
  before_save :convert_to_datetime

  def requested_date_field
    requested_datetime.strftime("%m/%d/%Y") if requested_datetime.present?
  end 

  def requested_time_field
    requested_datetime.strftime("%I:%M%p") if requested_datetime.present?
  end

  def requested_date_field=(date)
    # Change back to datetime friendly format
    components = date.split('/')
    date = components[1]+'/'+components[0]+'/'+components[2]
    @requested_date_field = Date.parse(date).strftime("%Y-%m-%d")
  end

  def requested_time_field=(time)
    # Change back to datetime friendly format
    time += " -0800"
    @requested_time_field = Time.parse(time).strftime("%H:%M:%S %z")
  end

  def convert_to_datetime
    self.requested_datetime = DateTime.parse("#{@requested_date_field} #{@requested_time_field}")
  end

	def assigned?
    !self.datascientist.nil?
  end

  def self.status_is(status)
    where("status = ?", status)
  end

  def self.status_is(status)
    where("status = ?", status)
  end
  
end
