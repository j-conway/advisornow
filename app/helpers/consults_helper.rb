module ConsultsHelper

  def status_default
    if !@status
      @status = "Open"
    end
  end

end