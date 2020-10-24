class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    return unless check_permission

    # render :layout => 'application'
    render layout: 'application'
    # 33
  end

  def toggle_hidden
    # toggle "show_hidden" value in cookies
    cookies[:show_hidden] = if cookies[:show_hidden] == '0'
                              '1'
                            else
                              '0'
                            end
    logger.info request.env['HTTP_REFERER']

    # go back or go to main page
    if request.env['HTTP_REFERER'].nil?
      redirect_to root_path
    else
      redirect_to(:back)
    end
  end

  def no_permissions
    # if !check_permission then return end
  end

  # check if cookies indicate that user is logged it
  def check_login
    # get the cookie value
    user = User.where('id =' + session[:login_id].to_s) unless session[:login_id].nil?
    # check if it corresponds with any user
    if user && user.first && session[:login_user] == user.first.name
      true
    else
      # redirect to login path if not
      redirect_to login_index_path, notice: (notice || '') + 'please log in' unless performed?
      false
    end
  end

  # check for user's permissions to an action
  def check_permission
    if check_login
      # assuming roles in format "controllerName_actionName" - permission to an action
      # or "controllerName" - permission to a controller
      # or "*" - permission to everything
      sql_query = 'user_id =' + session[:login_id].to_s +
                  ' AND (name like "' + controller_name.to_s + '_' + action_name.to_s + '"' +
                  ' OR name like "' + controller_name.to_s + '"' +
                  ' OR name like "*")'

      roles = Role.where(sql_query)
    end

    if (roles && roles.length < 1) || !roles
      redirect_to application_no_permissions_path, notice: 'no permissions, sorry ' unless performed?
      return false
    end
    # has permissions
    true
  end
end
