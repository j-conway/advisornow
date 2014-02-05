class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @company = current_company
      status_default
      unpaginated_consults = current_user.cust_consults.status_is(@status)
      @consults = unpaginated_consults.paginate(page:params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end


end

