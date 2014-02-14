class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @company = current_company
      @consult = @company.consults.build
      @length_choices = [1.0,1.5,2.0,2.5,3.0,3.5,4.0]
      @users = @company.users.paginate(page: params[:page])
      consults_filter
      open_consults = @company.consults.where("status = 'Open'")
      closed_consults = @company.consults.where("status = 'Closed'")
      ordered_open_consults = open_consults.order(:id)
      ordered_closed_consults = closed_consults.order(:id)
      @open_consults = ordered_open_consults.paginate(page:params[:page])
      @closed_consults = ordered_closed_consults.paginate(page:params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end


end

