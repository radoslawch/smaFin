# frozen_string_literal: true

# Controller for users.
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users
  # GET /users.json
  def index
    return unless check_permission

    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    return unless check_permission
  end

  # GET /users/new
  def new
    return unless check_permission

    @user = User.new
  end

  # GET /users/1/edit
  def edit
    return unless check_permission
  end

  # POST /users
  # POST /users.json
  def create
    return unless check_permission

    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    return unless check_permission

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    return unless check_permission

    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :password)
  end
end
