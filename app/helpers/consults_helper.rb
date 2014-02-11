module ConsultsHelper

  def filter_define
    @filter = params[:status]
    if !@filter
      @filter = "Open" 
    end
  end
end