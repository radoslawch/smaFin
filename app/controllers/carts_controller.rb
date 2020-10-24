# frozen_string_literal: true

# Controller for carts.
class CartsController < ApplicationController
  def index
    return unless check_permission

    # get carts for logged user
    @carts = Cart.where("user_id=#{session[:login_id]}")
  end

  def show
    return unless check_permission

    # to show chosen cart
    @cart = Cart.find(params[:id])
    # which contains some purchases
    @purchases = Purchase.left_joins(:cart).where("cart_id=#{params[:id]} and user_id=#{session[:login_id]}")

    # to add next purchase easly
    @purchase = Purchase.new
    # to chose a product to add
    @products = Product.left_joins(subcategory: :category).where("user_id=#{session[:login_id]}")
    # which has some category and subcategory
    @subcategories = Subcategory.left_joins(:category).where("user_id=#{session[:login_id]}")
    @categories =  Category.where("user_id=#{session[:login_id]}")

    @cant_add_purchase_reason = cant_add_purchase_reason_string

    @cart.current_user_id = session[:login_id]
    redirect_to carts_path, notice: @cart.errors.full_messages.join(', ') unless @cart.valid?
  end

  def cant_add_purchase_reason_string
    cant_add_purchase_reason = ''
    cant_add_purchase_reason += 'Add a category first! ' if @categories.empty?
    cant_add_purchase_reason += 'Add a subcategory first! ' if @subcategories.empty?
    cant_add_purchase_reason += 'Add a product first! ' if @products.empty?
    cant_add_purchase_reason
  end

  # new cart view
  def new
    return unless check_permission

    @cart = Cart.new
  end

  # edit a cart
  def edit
    return unless check_permission

    @cart = Cart.find(params[:id])

    @cart.current_user_id = session[:login_id]
    redirect_to carts_path, notice: @cart.errors.full_messages.join(', ') unless @cart.valid?
  end

  # create a cart (after new)
  def create
    return unless check_permission

    @cart = Cart.new(cart_params)
    @cart.current_user_id = session[:login_id]

    if @cart.save
      redirect_to @cart
    else
      render 'new'
    end
  end

  # update a cart (after edit)
  def update
    return unless check_permission

    @cart = Cart.find(params[:id])
    @cart.current_user_id = session[:login_id]

    if @cart.update(cart_params)
      redirect_to @cart
    else
      render 'edit'
    end
  end

  def destroy
    return unless check_permission

    @cart = Cart.find(params[:id])
    @cart.destroy_cascade(session[:login_id])
    # @cart.destroy
    redirect_to carts_path

    # @cart = Cart.find(params[:id])

    # @purchases = Purchase.where("cart_id = " + @cart.id.to_s)

    # if @purchases.length > 0 then
    # for purchase in @purchases do
    # purchase.destroy
    # end
    # end

    # redirect_to carts_path
  end

  # hide a cart (mark as hidden)
  def hide
    return unless check_permission

    @cart = Cart.find(params[:id])

    # method from a model
    @cart.hide(session[:login_id])

    redirect_to carts_path
  end

  def unhide
    return unless check_permission

    @cart = Cart.find(params[:id])

    # method from a model
    @cart.unhide(session[:login_id])

    redirect_to carts_path
  end

  private

  def cart_params
    # params.require(:cart).permit(:name, :creation_date, "dupa",   :user_id => [session[:login_id].to_s])
    # params = ActionController::Parameters.new({
    # cart: {
    # name: @cart.name,
    # creation_date:  @cart.creation_date,
    # user_id: session[:login_id]
    # }
    # })
    # params.require(:cart).permit(:name, :created, :user_id)
    params[:cart][:user_id] = session[:login_id]
    params.require(:cart).permit(:name, :creation_date, :user_id)
  end
end
