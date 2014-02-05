module ConsultsHelper

  def status_default
    @status = params[:status]
    if !@status
      @status = "Open"
    end
  end

end