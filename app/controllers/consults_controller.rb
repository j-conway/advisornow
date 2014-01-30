class ConsultsController < ApplicationController

  def index
  end

  def show
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
end