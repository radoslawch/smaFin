class LoginController < ApplicationController
  # before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    if session[:login_user] && session[:login_id]
        user = User.where("id =" + session[:login_id].to_s)        
        if user.first && session[:login_user] == user.first.name &&
        session[:login_id] == user.first.id then
            redirect_to root_path
        end
    end
    @users = User.all
  end

 
  # POST /users
  # POST /users.json
  def create
    user = User.where("name like \"" + params[:user] +"\"")
    respond_to do |format|
      if user.first && user.first.password == params[:password]
        session[:login_user] = user.first.name
        session[:login_id] = user.first.id
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
    session[:login_user] = "-1"
    session[:login_id] = "-1"
    if request.env["REQUEST_URI"] == "/logout"
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
    def login_params
      # params.require(:login).permit(:paassword)
    end
end
