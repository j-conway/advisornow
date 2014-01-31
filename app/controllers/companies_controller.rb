class CompaniesController < ApplicationController
  before_action :correct_company, :unless => :alpine_session?, only: [:show]
  before_action :alpine_check, only: [:index]


  def show
  	@company = Company.find(params[:id])
    @consults = @company.consults.paginate(page: params[:page])
    @users = @company.users.paginate(page: params[:page])
    @user = current_company.users.build
    @consult = current_company.consults.build
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
      @company = Company.find(params[:id])
      redirect_to(root_url) unless current_company?(@company)
    end

end