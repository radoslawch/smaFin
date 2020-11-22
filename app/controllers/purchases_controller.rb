# frozen_string_literal: true

# Controller for purchases of products.
class PurchasesController < ApplicationController
  def index
    return unless check_permission

    @purchases = Purchase.left_joins(:cart).where("user_id=#{session[:login_id]}")
  end

  def show
    return unless check_permission

    purchase_from_params

    redirect_to purchases_path, notice: 'error, purchase does not exist' unless @purchase

    # workaround for no auto-validation on this action
    redirect_to purchases_path, notice: @purchase.errors.full_messages.join(', ') unless @purchase.valid?
  end

  def new
    return unless check_permission

    purchase_from_params

    read_users_products

    notice_string = ''
    notice_string += 'Add a cart first! ' if @carts.empty?
    notice_string += 'Add a category first! ' if @categories.empty?
    notice_string += 'Add a subcategory first! ' if @subcategories.empty?
    notice_string += 'Add a product first! ' if @products.empty?
    redirect_to purchases_path, notice: notice_string if notice_string != ''
  end

  def edit
    return unless check_permission

    purchase_from_params

    read_users_products

    redirect_to purchases_path, notice: 'error, purchase does not exist' unless @purchase

    # workaround for no auto-validation on this action
    redirect_to purchases_path, notice: @purchase.errors.full_messages.join(', ') unless @purchase.valid?
  end

  def create
    return unless check_permission

    purchase_from_params

    read_users_products

    if @purchase.save
      redirect_to @purchase.cart
    else
      puts @purchase.errors.inspect
      render 'new'
    end
  end

  def update
    return unless check_permission

    purchase_from_params

    read_users_products

    if @purchase.update(purchase_params)
      redirection_target = purchases_path
      redirection_target = @purchase.cart if params[:redirect_to_cart] == 'true'
      redirect_to redirection_target
    else
      render 'edit'
    end
  end

  def destroy
    return unless check_permission

    @purchase = Purchase.find(params[:id])
    @purchase.destroy_cascade(session[:login_id])

    redirect_to purchases_path
  end

  def hide
    return unless check_permission

    @purchase = Purchase.find(params[:id])

    @purchase.hide(session[:login_id])

    redirect_to @purchase.cart
  end

  def unhide
    return unless check_permission

    @purchase = Purchase.find(params[:id])

    @purchase.unhide(session[:login_id])

    redirect_to @purchase.cart
  end

  private

  def read_users_products
    @carts = Cart.where("user_id=#{session[:login_id]}")
    @products = Product.left_joins(subcategory: :category).where("user_id=#{session[:login_id]}")

    @subcategories = Subcategory.where(['id IN (?)', @products.pluck(:subcategory_id)])
    @categories = Category.where(['id IN (?)', @products.pluck(:category_id)])
  end

  def purchase_from_params
    @purchase =
      if params[:id]
        Purchase.find(params[:id])
      elsif params[:purchase]
        Purchase.new(purchase_params)
      else
        Purchase.new
      end
    @purchase.current_user_id = session[:login_id]
  end

  def purchase_params
    params.require(:purchase).permit(:cart_id, :product_id, :amount, :price, :name, :redirect_to_cart)
  end
end
