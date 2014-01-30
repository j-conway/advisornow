class MeetingsController < ApplicationController
  def show
    @meeting = Meeting.find(params[:id])
    @members = @meeting.meeting_members.paginate(page: params[:page])
  end

  def new
  end
end
