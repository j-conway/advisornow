class ConsultsController < ApplicationController
  before_action :correct_company, :unless => :alpine_session?, only: [:show, :index]


  def index
    if params[:company_id]
      @company = Company.find(params[:company_id])
      consults_filter
      unpaginated_consults = @company.consults.status_is(@consult_filter)
      ordered_consults = unpaginated_consults.select("consults.*").joins(:meetings).where("meetings.status = 'Open'").group("consults.id").order("min(meeting_datetime)")
      @consults = ordered_consults.paginate(:page => params[:page], :per_page => 10)
    else
      consults_filter
      unpaginated_consults = Consult.status_is(@consult_filter)
      ordered_consults = unpaginated_consults.select("consults.*").joins(:meetings).where("meetings.status = 'Open'").group("consults.id").order("min(meeting_datetime)")
      @consults = ordered_consults.paginate(:page => params[:page], :per_page => 10)
    end
  end

  def show
    @current_user = current_user
    @consult = Consult.find(params[:id])
    @users = @consult.consult_members.paginate(page: params[:page])
    @meetings = @consult.meetings.paginate(page: params[:page])
    @meeting = @consult.meetings.build
    @creator = User.find(@consult.creator_id)
    @length_choices = [1.0,1.5,2.0,2.5,3.0,3.5,4.0]
  end

  def new
    @company = Company.find(params[:company_id])
    @consult = @company.consults.build
    @consult.meetings.build
    @users = @company.users.paginate(page: params[:page])
    @length_choices = [1.0,1.5,2.0,2.5,3.0,3.5,4.0]
  end


  def create
    @company = Company.find(params[:company_id])
    @consult = @company.consults.build(consult_params)
    @consult.requested = true
    @consult.creator = current_user
    if !alpine_session?
      @consult.customer_id = current_user.id
      @consult.datascientist_id = nil
    end
    @consult.status = "Open"
    if @consult.save
      @meeting = Meeting.create!(
            :consult_id => @consult.id,
            :description => "Initial meeting",
            :meeting_date_field => @consult.consult_date_field,
            :meeting_time_field => @consult.consult_time_field,
            :meeting_length => @consult.requested_length,
            :status => "Open",
            :requester_id => current_user.id,
            :requested => true,
            :datascientist_id => @consult.datascientist_id,
        )
      if params[:consult_type] == "schedule"
        @meeting.update_column(:requested, false)
      end
      flash[:success] = "Consult added."
      redirect_to company_path(@company)
    else
      render 'new'
    end
  end

  def edit
    @company = Company.find(params[:company_id])
    @consult = Consult.find(params[:id])
    @length_choices = [1.0,1.5,2.0,2.5,3.0,3.5,4.0]
    @users = @company.users.paginate(page: params[:page])
  end

  def update
    @company = Company.find(params[:company_id])
    @consult = Consult.find(params[:id])
    if @consult.update_attributes(consult_params)
      flash[:success] = "Consult updated"
      redirect_to company_consult_path
    else
      render 'edit'
    end
  end

  def destroy
  end



  private


    def consult_params
      params.require(:consult).permit(:customer_id, :datascientist_id, :subject, :description, :consult_date_field, :consult_time_field, :requested_length, :requested, :consult_type)
    end

    def correct_company
      if params[:company_id]
        company = Company.find(params[:company_id]) 
        redirect_to(root_url) unless current_company?(company)
      else
        redirect_to(root_url)
      end
    end



end