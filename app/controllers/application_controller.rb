class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    if !check_permission then return end
  end
  
  def toggle_hidden
  # toggle "show_hidden" value in cookies
    if cookies[:show_hidden] == "0"
      cookies[:show_hidden] = "1"
    else
      cookies[:show_hidden] = "0"
    end
    logger.info request.env["HTTP_REFERER"]

  # go back or go to main page
    if request.env["HTTP_REFERER"].nil?
      redirect_to root_path
    else
      redirect_to(:back)
    end
  end
  
  # def user1
    # session[:user_id ] = 1
    # if request.env["HTTP_REFERER"].nil?
      # redirect_to root_path
    # else
      # redirect_to(:back)
    # end
  # end  
  
  # def user2
    # session[:user_id ] = 2
    # if request.env["HTTP_REFERER"].nil?
      # redirect_to root_path
    # else
      # redirect_to(:back)
    # end
  # end
  
  # check if cookies indicate that user is logged it
  def check_login
  # get the cookie value
    if !cookies.signed[:login_id].nil?
        user = User.where("id =" + cookies.signed[:login_id].to_s)
    end
  # check if it corresponds with any user
    if user && user.first && cookies.signed[:login_user] == user.first.name then
        true
    else
  # redirect to login path if not
        redirect_to login_index_path, notice: (notice || "") + 'please log in' 
        return
    end
  end

  # check for user's permissions to an action
  def check_permission
    if check_login then
      # assuming roles in format "controllerName_actionName" - permission to an action
      # or "controllerName" - permission to a controller
      # or "*" - permission to everything
        sql_query = "user_id =" + cookies.signed[:login_id].to_s +
        " AND (name like \"" + controller_name.to_s + "_" + action_name.to_s + "\"" +
        " OR name like \"" + controller_name.to_s + "\"" +
        " OR name like \"*\")"
        logger.error sql_query
        roles = Role.where(sql_query)
    end
    
    if (roles && roles.length < 1) then

      if !request.env["HTTP_REFERER"].nil? then
        # avoid redirection loop
        if request.env["HTTP_REFERER"] != cookies.signed[:last_HTTP_REFERER] then
          cookies.signed[:last_HTTP_REFERER] = request.env["HTTP_REFERER"]
          redirect_to :back, notice: 'no permissions, sorry'
        else
          redirect_to logout_path, notice: 'account has no permissions, '
        end
      else
        redirect_to application_index_path, notice: 'no permissions, sorry'
      end 
      return false
    end
  return true 
  end 
end
