module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Advisor Now"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def consult_status(consult)
    if consult.next_open_meeting.requested?
      "pending-consult"
    else
      "scheduled-consult"
    end
  end

  def consult_next_meeting(consult)
		if consult.status == "Open"
      "#{consult.next_open_meeting.meeting_date_field} at #{consult.next_open_meeting.meeting_time_field}"
    else
      "--"
    end
  end
end