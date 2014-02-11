class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @company = current_company
      filter_define
      unpaginated_consults = current_user.consults.status_is(@filter)
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

