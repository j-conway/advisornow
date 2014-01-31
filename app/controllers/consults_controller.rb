class ConsultsController < ApplicationController
  before_action :correct_company, :unless => :alpine_session? , only: [:show]

  def index
  end

  def show
    @current_user = current_user
    @consult = Consult.find(params[:id])
    @users = @consult.consult_members.paginate(page: params[:page])
    @meetings = @consult.meetings.paginate(page: params[:page])
    @meeting = @consult.meetings.build
  end

  def new
  end


  def create
    @company = Company.find(params[:company_id])
    @consult = @company.consults.build(consult_params)
    @consult.creator = current_user
    if !alpine_session?
      @consult.customer_id = current_user
      @consult.datascientist_id = nil
      @consult.datascientist_status = "No"
    else
      @consult.datascientist_status = "Yes"
    end
    @consult.status = "Open"
    if @consult.save
      flash[:success] = "Consult added."
      redirect_to company_path(@company)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private


    def consult_params
      
      params.require(:consult).permit(:customer_id, :datascientist_id, :subject)
      if alpine_session?
        params.
      else
        customer = true
      end
    end

    def correct_company
      @company = Consult.find(params[:id]).company
      redirect_to(root_url) unless current_company?(@company)
    end

end