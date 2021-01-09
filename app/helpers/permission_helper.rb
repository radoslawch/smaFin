module PermissionHelper
  # check for user's permissions to an action
  # when passing no arguments check for current controller and action
  def check_permission_helper(c_name = controller_name, a_name = action_name)
    # assuming roles in format "controllerName_actionName" - permission to an action
    # or "controllerName" - permission to a controller
    # or "*" - permission to everything
    sql_query = 'user_id=?
      AND ((controller_name LIKE ? AND action_name LIKE ?)
      OR (controller_name LIKE ? AND action_name LIKE "*")
      OR controller_name LIKE "*")'
    query_array = [ session[:login_id].to_s, c_name, a_name, c_name]
    check_permission_base(sql_query, query_array)
  end

  def check_permission_base(sql_query, query_array)
    roles = Role.where([sql_query, query_array].flatten)
    return true unless roles&.empty?
    false
  end

  # check if cookies indicate that user is logged it
  def check_login_helper
    # get the cookie value
    user = User.where("id=#{session[:login_id]}") unless session[:login_id].nil?
    # check if it corresponds with any user
    if user&.first && session[:login_user] == user.first.name
      true
    else
      false
    end
  end

  def has_permission(c_name, a_name)
    check_permission_helper(c_name, a_name)
  end
end
