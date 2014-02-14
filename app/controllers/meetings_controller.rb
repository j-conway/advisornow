class MeetingsController < ApplicationController
  def show
    @meeting = Meeting.find(params[:id])
    @consult = Consult.find(params[:consult_id])
    @company = Company.find(@consult.company.id)
    @members = @meeting.meeting_members.paginate(page: params[:page])
    @length_choices = [1.0,1.5,2.0,2.5,3.0,3.5,4.0]
  end

  def new
    @consult = Consult.find(params[:consult_id])
    @meeting = @consult.meetings.build
    @length_choices = [1.0,1.5,2.0,2.5,3.0,3.5,4.0]
  end

  def create
    if params[:consult_id]
      @consult = Consult.find(params[:consult_id])
    else
      @consult = Consult.find(meeting_params[:consult_id])
    end
    @company = Company.find(@consult.company.id)
    @meeting = @consult.meetings.build(meeting_params)
    if @meeting.save
      if params[:meeting_type] == "schedule"
        @meeting.update_column(:requested, false)
      end
      flash[:success] = "Meeting created!"
      redirect_to [@company, @consult]
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def edit
    @consult = Consult.find(params[:consult_id])
    @meeting = Meeting.find(params[:id])
    @length_choices = [1.0,1.5,2.0,2.5,3.0,3.5,4.0]
  end

  def update
    @consult = Consult.find(params[:consult_id])
    @meeting = Meeting.find(params[:id])
    @company = Company.find(@consult.company.id)
    if !meeting_params[:description]
      if @meeting.update_column(:requested, false)
        @meeting.update_column(:datascientist_id, meeting_params[:datascientist_id])
        flash[:success] = "Consult confirmed"
        redirect_to @company
      end
    elsif @meeting.update_attributes(meeting_params)
      if params[:meeting_type] == "force"
        @meeting.update_column(:requested, false)
      end
      flash[:success] = "Consult updated"
      redirect_to @company
    else
      render 'show'
    end
  end

  private

    def meeting_params
      params.require(:meeting).permit(:consult_id, :description, :meeting_date_field, :meeting_time_field, :meeting_length, :status, :requester_id, :requested, :datascientist_id)
    end
end
