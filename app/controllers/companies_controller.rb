class CompaniesController < ApplicationController
  before_action :correct_company, only: [:show]


  def show
  	@company = Company.find(params[:id])
    @consults = @company.consults.paginate(page: params[:page])
    @user = current_company.users.build
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

  private

    def company_params
       params.require(:company).permit(:name, :entitlements)
    end

  	def correct_company
      @company = Company.find(params[:id])
      redirect_to(root_url) unless current_company?(@company)
    end

end