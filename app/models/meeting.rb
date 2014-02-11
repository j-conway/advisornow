class Meeting < ActiveRecord::Base
	belongs_to :consult
	has_many :meeting_memberships
  has_many :meeting_members, :through => :meeting_memberships, :source => :user
  validates :description, presence: true, length: { maximum: 150 }
  validates :consult_id, presence: true
  before_save :update_consult_status
  before_save :convert_meeting_to_datetime
    

  def update_consult_status
    consult.update_column(:requested, false)
  end

  def meeting_date_field
    meeting_datetime.in_time_zone("Pacific Time (US & Canada)").strftime("%m/%d/%Y") if meeting_datetime.present?
  end 

  def meeting_time_field
    meeting_datetime.in_time_zone("Pacific Time (US & Canada)").strftime("%I:%M%p") if meeting_datetime.present?
  end

  def meeting_date_field=(date)
    # Change back to datetime friendly format
    @meeting_date_field = Date.strptime(date, "%m/%d/%Y")
  end

  def meeting_time_field=(time)
    # Change back to datetime friendly format
    @meeting_time_field = Time.parse(time).strftime("%H:%M:%S %z").in_time_zone("Pacific Time (US & Canada)")
  end

  def convert_meeting_to_datetime
    self.meeting_datetime = DateTime.parse("#{@meeting_date_field} #{@meeting_time_field}")
  end
end
