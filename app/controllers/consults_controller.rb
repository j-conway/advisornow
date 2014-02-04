class ConsultsController < ApplicationController

  before_action :correct_company, :unless => :alpine_session?, only: [:show, :index]


  def index
    if params[:company_id]
      @company = Company.find(params[:company_id])
      @consults = @company.consults.paginate(page:params[:page])
    else
      @consults = Consult.paginate(page:params[:page])
    end
  end

  def show
    @current_user = current_user
    @consult = Consult.find(params[:id])
    @users = @consult.consult_members.paginate(page: params[:page])
    @meetings = @consult.meetings.paginate(page: params[:page])
    @meeting = @consult.meetings.build
    @requested_lengths = [1.0,1.5,2.0,2.5,3.0,3.5,4.0]
  end

  def new
    @company = Company.find(params[:company_id])
    @consult = @company.consults.build
    @users = @company.users.paginate(page: params[:page])
    @requested_lengths = [1.0,1.5,2.0,2.5,3.0,3.5,4.0]
  end


  def create
    @company = Company.find(params[:company_id])
    @consult = @company.consults.build(consult_params)
    @consult.creator = current_user
    if !alpine_session?
      @consult.customer_id = current_user.id
      @consult.datascientist_id = nil
    end
    @consult.status = "Requested"
    if @consult.save
      flash[:success] = "Consult added."
      redirect_to company_path(@company)
    else
      render 'new'
    end
  end

  def edit
    @company = Company.find(params[:company_id])
    @consult = Consult.find(params[:id])
    @requested_lengths = [1.0,1.5,2.0,2.5,3.0,3.5,4.0]
    @users = @company.users.paginate(page: params[:page])
  end

  def update
    @company = Consult.find(params[:company_id])
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
      
      params.require(:consult).permit(:customer_id, :datascientist_id, :subject, :description, :requested_date, :requested_time, :requested_length)
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