class CompaniesController < ApplicationController
  before_action :correct_company, :unless => :alpine_session?, only: [:show]
  before_action :alpine_check, only: [:index]


  def show
  	@company = Company.find(params[:id])
    @consults = @company.consults.paginate(page: params[:page])
    @users = @company.users.paginate(page: params[:page])
    @user = current_company.users.build
    @consult = current_company.consults.build
    @scheduled_lengths = [1.0,1.5,2.0,2.5,3.0,3.5,4.0]
  end

  def new
  	@company = Company.new
  end

  def create
  	@company = Company.new(company_params)
  	if @company.save
  	  flash[:success] = "Good job, new company!"
      redirect_to @company
  	else
  		render 'new'
  	end
  end

  def index
    @companies = Company.paginate(page:params[:page])
  end

  private

    def company_params
       params.require(:company).permit(:name, :entitlements)
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