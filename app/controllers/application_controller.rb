# frozen_string_literal: true

# Controller with global application methods.
class ApplicationController < ActionController::Base
  include PermissionHelper
  protect_from_forgery with: :exception

  def index
    return unless check_permission

    render layout: 'application'
  end

  def toggle_hidden
    cookies[:show_hidden] = (cookies[:show_hidden] == '0' ? '1' : '0')

    redirect_back(fallback_location: root_path)
  end

  def no_permissions
    # if !check_permission then return end
  end

  def check_permission
    if check_login
      if check_permission_helper
        return true
      end
    end

    redirect_to application_no_permissions_path, notice: 'no permissions, sorry ' unless performed?
    false
  end

  def check_login
    if check_login_helper
      return true
    end
    notice += ';' unless notice.blank?
    redirect_to login_index_path, notice: "#{notice} please log in" unless performed?
    false
  end
end
