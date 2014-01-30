class MeetingsController < ApplicationController
  def show
    @meeting = Meeting.find(params[:id])
    @consult = Consult.find(params[:consult_id])
    @members = @meeting.meeting_members.paginate(page: params[:page])
  end

  def new
    @meeting = Meeting.new
  end


  def create
    if params[:consult_id]
      @consult = Consult.find(params[:consult_id])
    else
      @consult = Consult.find(meeting_params[:consult_id])
    end
    @meeting = @consult.meetings.build(meeting_params)
    if @meeting.save
      flash[:success] = "Meeting created!"
      redirect_to [@consult, @meeting]
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  private

    def meeting_params
      params.require(:meeting).permit(:consult_id, :description)
    end
end
