# frozen_string_literal: true

# Login controller which authenticates users.
class LoginController < ApplicationController
  def index
    return unless session[:login_user] && session[:login_id]

    user = User.where("id=#{session[:login_id]}")
    return unless user.first && user.first.name == session[:login_user]

    redirect_to root_path
    # @users = User.all
  end

  # POST /users
  # POST /users.json
  def create
    user = User.where("name like '#{params[:user]}'")
    respond_to do |format|
      if user.first&.password == params[:password]
        login_sucessfull user
        format.html { redirect_to root_path, notice: 'User was successfully logged in.' }
      else
        clear_login
        format.html { redirect_to :login_index, notice: 'Logon unsuccessful' }
      end
    end
  end

  def login_sucessfull(user)
    session[:login_user] = user.first.name
    session[:login_id] = user.first.id
  end

  # remove login data
  def clear_login
    session[:login_user] = '-1'
    session[:login_id] = '-1'
    redirect_to root_path if request.env['REQUEST_URI'] == '/logout'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def login_params
    # params.require(:login).permit(:paassword)
  end
end
