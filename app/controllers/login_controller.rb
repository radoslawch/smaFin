class LoginController < ApplicationController
  # before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    if cookies.signed[:login_user] && cookies.signed[:login_id]
        user = User.where("id =" + cookies.signed[:login_id].to_s)        
        if user.first && cookies.signed[:login_user] == user.first.name &&
        cookies.signed[:login_id] == user.first.id then
            redirect_to root_path
        end
    end
    @users = User.all
  end

 
  # POST /users
  # POST /users.json
  def create
    user = User.where("name like \"" + params[:u] +"\"")
    respond_to do |format|
      if user.first && user.first.password == params[:p]
        cookies.signed[:login_user] = user.first.name
        cookies.signed[:login_id] = user.first.id
        format.html { redirect_to root_path, notice: 'User was successfully logged in.' }
        # format.json { render :show, status: :created, location: @user }
      else
        clear_login
        format.html { redirect_to :login_index, notice: 'Logon unsuccessful' }
        # format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # remove login data
  def clear_login
    cookies.signed[:login_user] = "-1"
    cookies.signed[:login_id] = "-1"
    if request.env["REQUEST_URI"] == "/application/logout"
      redirect_to root_path
    else
    end
  end

 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
	

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.fetch(:user, {})
    end
end
