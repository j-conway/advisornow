class StaticPagesController < ApplicationController
  def home
    @status = params[:status]
    if !@status
      @status = "Open"
    end
      if signed_in?
        @current_user = current_user
        consults_with_status = @current_user.consults.status_is(@status)
        @consults = consults_with_status.paginate(page: params[:page])
      end
  end

  def help
  end

  def about
  end

  def contact
  end

end
