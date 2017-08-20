class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def toggle_hidden
    logger.info 'jestę w toggle hiddę'
    if cookies[:show_hidden] == "0"
      cookies[:show_hidden] = "1"
    else
      cookies[:show_hidden] = "0"
    end
    logger.info request.env["HTTP_REFERER"]
    if request.env["HTTP_REFERER"].nil?
      redirect_to root_path
    else
      redirect_to(:back)
    end
  end

end
