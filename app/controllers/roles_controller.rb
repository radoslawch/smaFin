class RolesController < ApplicationController
  before_action :set_role, only: %i[show edit update destroy]

  # GET /roles
  # GET /roles.json
  def index
    return unless check_permission

    @roles = Role.left_joins(:user)
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
    return unless check_permission
  end

  # GET /roles/new
  def new
    return unless check_permission

    @role = Role.new
    @users = User.all
  end

  # GET /roles/1/edit
  def edit
    return unless check_permission

    @users = User.all
  end

  # POST /roles
  # POST /roles.json
  def create
    return unless check_permission

    @role = Role.new(role_params)
    respond_to do |format|
      if @role.save
        format.html { redirect_to @role, notice: 'Role was successfully created.' }
        format.json { render :show, status: :created, location: @role }
      else
        @users = User.all
        format.html { render :new }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    return unless check_permission

    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to @role, notice: 'Role was successfully updated.' }
        format.json { render :show, status: :ok, location: @role }
      else
        raise 'k'
        format.html { render :edit }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    return unless check_permission

    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_url, notice: 'Role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_role
    @role = Role.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def role_params
    params.
      # require(:role).
      fetch(:role, {})
          .permit(:user_id, :name)
  end
end
