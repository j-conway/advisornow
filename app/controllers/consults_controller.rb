class ConsultsController < ApplicationController
  before_action :correct_company, only: [:show]

  def index
  end

  def show
    @current_user = current_user
    @consult = Consult.find(params[:id])
    @users = @consult.consult_members.paginate(page: params[:page])
  end

  def new
  end


  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def correct_company
      @company = Consult.find(params[:id]).company
      redirect_to(root_url) unless current_company?(@company)
    end
end