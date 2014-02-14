module ConsultsHelper

  def consults_filter
    @consult_filter = params[:status]
    if !@consult_filter
      @consult_filter = "Open" 
    end
  end
end