# frozen_string_literal: true

# Controller for products.
class ProductsController < ApplicationController
  def index
    return unless check_permission

    @products = Product.left_joins(subcategory: :category).where("user_id=#{session[:login_id]}")
  end

  def show
    return unless check_permission

    @product = Product.find(params[:id])
    @product.current_user_id = session[:login_id]

    redirect_to products_path, notice: 'error, product does not exist' unless @product

    # workaround for no auto-validation on this action
    redirect_to products_path, notice: @product.errors.full_messages.join(', ') unless @product.valid?
  end

  def new
    return unless check_permission

    @product = Product.new
    @categories =  Category.where("user_id=#{session[:login_id]}")
    @subcategories = Subcategory.left_joins(:category).where("user_id=#{session[:login_id]}")
    if @categories.empty?
      redirect_to products_path, notice: 'Add a category first!'
    elsif @subcategories.empty?
      redirect_to products_path, notice: 'Add a subcategory first!'
    end
  end

  def edit
    return unless check_permission

    # left join subcategory to show current subcategory name
    @product = Product.left_joins(:subcategory).find(params[:id])
    @product.current_user_id = session[:login_id]

    @categories =  Category.where("user_id=#{session[:login_id]}")
    # is left join needed?
    @subcategories = Subcategory.left_joins(:category).where("user_id=#{session[:login_id]}")

    redirect_to subcategories_path, notice: 'product not found' unless @product

    # workaround for no auto-validation on this action
    redirect_to subcategories_path, notice: @product.errors.full_messages.join(', ') unless @product.valid?
  end

  def create
    return unless check_permission

    @product = Product.new(product_params)
    @product.current_user_id = session[:login_id]

    if @product.save
      redirect_to @product
    else
      @categories =  Category.where("user_id=#{session[:login_id]}")
      @subcategories = Subcategory.left_joins(:category).where("user_id=#{session[:login_id]}")
      render 'new'
    end
  end

  def update
    return unless check_permission

    @product = Product.find(params[:id])
    @product.current_user_id = session[:login_id]

    if @product.update(product_params)
      redirect_to @product
    else
      @categories =  Category.where("user_id=#{session[:login_id]}")
      @subcategories = Subcategory.left_joins(:category).where("user_id=#{session[:login_id]}")
      render 'edit'
    end
  end

  def destroy
    return unless check_permission

    @product = Product.find(params[:id])
    @product.destroy_cascade(session[:login_id])
    # @product.destroy
    redirect_to products_path

    # @product = Product.find(params[:id])

    # @purchases = Purchase.where("product_id = " + @product.id.to_s)

    # if @purchases.length > 0 then
    # for purchase in @purchases do
    # purchase.destroy
    # end
    # end
    # @product.destroy

    # redirect_to products_path
  end

  def hide
    return unless check_permission

    @product = Product.find(params[:id])

    # method from a model
    @product.hide(session[:login_id])

    redirect_to products_path
  end

  def unhide
    return unless check_permission

    @product = Product.find(params[:id])

    # method from a model
    @product.unhide(session[:login_id])

    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:subcategory_id, :name, :unit)
  end
end
