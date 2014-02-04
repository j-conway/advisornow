class StaticPagesController < ApplicationController
  def home
    status_default
    unpaginated_consults = current_user.consults.status_is(@status)
    @consults = unpaginated_consults.paginate(page:params[:page])
  end

  def help
  end

  def about
  end

  def contact
  end


end

