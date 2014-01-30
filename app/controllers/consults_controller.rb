class ConsultsController < ApplicationController

  def index
  end

  def show
    @consult = Consult.find(params[:id])
    @users = @consult.consult_members.paginate(page: params[:page])
    @meetings = @consult.meetings.paginate(page: params[:page])
    @meeting = @consult.meetings.build
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

    def consult_params
      if current_user.alpine_user?
        customer = false
      else
        customer = true
      end
      params.require(:consult).permit(:creator_id => current_user, :customer_id, :datascientist_id, :subject, :status, :datascientist_status)
    end

end