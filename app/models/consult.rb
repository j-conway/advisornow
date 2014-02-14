class Consult < ActiveRecord::Base
  belongs_to :creator, :class_name => 'User'
	belongs_to :customer, :class_name => 'User'
	belongs_to :datascientist, :class_name => 'User'
  has_one :company, :through => :customer
	has_many :consult_memberships
	has_many :consult_members, :through => :consult_memberships, :source => :user
	has_many :meetings
  before_save :convert_consult_to_datetime
  
  attr_accessor :consult_type

  def consult_date_field
    requested_datetime.in_time_zone("Pacific Time (US & Canada)").strftime("%m/%d/%Y") if requested_datetime.present?
  end 

  def consult_time_field
    requested_datetime.in_time_zone("Pacific Time (US & Canada)").strftime("%I:%M%p") if requested_datetime.present?
  end
  def consult_date_field=(date)
    # Change back to datetime friendly format
    @consult_date_field = Date.strptime(date, "%m/%d/%Y")
  end

  def consult_time_field=(time)
    # Change back to datetime friendly format
    @consult_time_field = Time.parse(time).strftime("%H:%M:%S %z").in_time_zone("Pacific Time (US & Canada)")
  end

  def convert_consult_to_datetime
    self.requested_datetime = DateTime.parse("#{@consult_date_field} #{@consult_time_field}")
  end

  def open_meetings
    self.meetings.where(:status => "Open").order(meeting_datetime: :asc)
  end
  
  def next_open_meeting
    self.open_meetings[0]
  end

  def next_open_meeting_datetime
    self.next_open_meeting.meeting_datetime
  end

	def assigned?
    !self.datascientist.nil?
  end

  def self.status_is(status)
    where("consults.status = ?", status)
  end

end
