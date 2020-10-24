# frozen_string_literal: true

# Controller for subcategories of categories.
class SubcategoriesController < ApplicationController
  def index
    return unless check_permission

    @subcategories = Subcategory.left_joins(:category).where("user_id=#{session[:login_id]}")
  end

  def show
    return unless check_permission

    @subcategory = Subcategory.left_joins(:category).find(params[:id])
    @subcategory.current_user_id = session[:login_id]

    redirect_to subcategories_path, notice: 'error, subcategory does not exist' unless @subcategory

    # workaround for no auto-validation on this action
    redirect_to subcategories_path, notice: @subcategory.errors.full_messages.join(', ') unless @subcategory.valid?
  end

  def new
    return unless check_permission

    @subcategory = Subcategory.new
    @categories = Category.where("user_id=#{session[:login_id]}")
    redirect_to subcategories_path, notice: 'Add a category first!' if @categories.empty?
  end

  def edit
    return unless check_permission

    # left join category to show current category name
    @subcategory = Subcategory.left_joins(:category).find(params[:id])
    @subcategory.current_user_id = session[:login_id]

    @categories = Category.where("user_id=#{session[:login_id]}")

    redirect_to subcategories_path, notice: 'subcategory not found' unless @subcategory

    # workaround for no auto-validation on this action
    redirect_to subcategories_path, notice: @subcategory.errors.full_messages.join(', ') unless @subcategory.valid?
  end

  # add auto-creation of a product? nah
  def create
    return unless check_permission

    @subcategory = Subcategory.new(subcategory_params)
    @subcategory.current_user_id = session[:login_id]

    @categories = Category.where("user_id=#{session[:login_id]}")

    if @subcategory.save
      redirect_to @subcategory
    else
      render 'new'
    end
  end

  def update
    return unless check_permission

    @subcategory = Subcategory.left_joins(:category).find(params[:id])
    @subcategory.current_user_id = session[:login_id]

    @categories = Category.where("user_id=#{session[:login_id]}")

    if @subcategory.update(subcategory_params)
      redirect_to @subcategory
    else
      render 'edit'
    end
  end

  def destroy
    return unless check_permission

    @subcategory = Subcategory.find(params[:id])
    @subcategory.destroy_cascade(session[:login_id])
    # @subcategory.destroy
    redirect_to subcategories_path

    # @subcategory = Subcategory.find(params[:id])
    # @products = Product.where("subcategory_id = " + @subcategory.id.to_s)
    # if @products.length > 0 then
    # for product in @products do
    # product.destroy
    # end
    # end
    # @subcategory.destroy

    # redirect_to subcategories_path
  end

  def hide
    return unless check_permission

    @subcategory = Subcategory.find(params[:id])
    # method from a model
    @subcategory.hide(session[:login_id])
    redirect_to subcategories_path
  end

  def unhide
    return unless check_permission

    @subcategory = Subcategory.find(params[:id])
    # method from a model
    @subcategory.unhide(session[:login_id])
    redirect_to subcategories_path
  end

  private

  def subcategory_params
    params.require(:subcategory).permit(:subcategory, :name, :category_id)
  end
end
