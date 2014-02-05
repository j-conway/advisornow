class StaticPagesController < ApplicationController
  def home
    if signed_in?
      status_default
      unpaginated_consults = current_user.consults.status_is(@status)
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

