class CompaniesController < ApplicationController
  before_action :correct_company, :unless => :alpine_session?, only: [:show]
  before_action :alpine_check, only: [:index, :new, :create, :edit]
  before_filter :authenticate

  def show
  	@company = Company.find(params[:id])
    @consults = @company.consults.paginate(page: params[:page])
    @users = @company.users.paginate(page: params[:page])
    @user = current_company.users.build
    @consult = current_company.consults.build
    @requested_lengths = [1.0,1.5,2.0,2.5,3.0,3.5,4.0]
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
    @company = Company.new
  end

  def edit
    @title = "Edit user"
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(company_params)
      redirect_to @company, :flash => { :success => "Profile updated." }
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  private

    def company_params
       params.require(:company).permit(:name, :entitlements)
    end

  	def correct_company
      if params[:id]
        company = Company.find(params[:id]) 
        redirect_to(root_url) unless current_company?(company)
      else
        redirect_to(root_url)
      end
    end

end