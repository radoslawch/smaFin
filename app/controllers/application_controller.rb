# frozen_string_literal: true

# Controller with global application methods.
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    return unless check_permission

    render layout: 'application'
  end

  def toggle_hidden
    cookies[:show_hidden] = (cookies[:show_hidden] == '0' ? '1' : '0')

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
    user = User.where("id=#{session[:login_id]}") unless session[:login_id].nil?
    # check if it corresponds with any user
    if user&.first && session[:login_user] == user.first.name
      true
    else
      # redirect to login path if not
      redirect_to login_index_path, notice: "#{notice}; please log in" unless performed?
      false
    end
  end

  # check for user's permissions to an action
  def check_permission
    if check_login
      # assuming roles in format "controllerName_actionName" - permission to an action
      # or "controllerName" - permission to a controller
      # or "*" - permission to everything

      roles = Role.where(['user_id=?
                            AND (name like ?
                            OR name like ?
                            OR name like "*")',
                          session[:login_id].to_s, "#{controller_name}_#{action_name}", controller_name])
      return true unless roles&.empty?
    end

    redirect_to application_no_permissions_path, notice: 'no permissions, sorry ' unless performed?
    false
  end
end
