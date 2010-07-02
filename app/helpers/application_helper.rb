# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def check_timeout
    if (session[:time])
      if ((Time.now - session[:time]) > 25.minutes)
        reset_session
      end
    else
      reset_session
    end   
  end
end
