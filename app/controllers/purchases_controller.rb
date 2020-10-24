class PurchasesController < ApplicationController
  def index # lista wydatków
    return unless check_permission

    @purchases = Purchase.left_joins(:cart).where('user_id =' + session[:login_id].to_s)
  end

  def show
    return unless check_permission

    @purchase = Purchase.find(params[:id])
    @purchase.current_user_id = session[:login_id]

    redirect_to purchases_path, notice: 'error, purchase does not exist' unless @purchase

    # workaround for no auto-validation on this action
    redirect_to purchases_path, notice: @purchase.errors.full_messages.join(', ') unless @purchase.valid?
  end

  def new # nowy wydatek - widok
    return unless check_permission

    @purchase = Purchase.new
    @carts =  Cart.where('user_id =' + session[:login_id].to_s)
    @products = Product.left_joins(subcategory: :category).where('user_id =' + session[:login_id].to_s)

    @subcategories = Subcategory.left_joins(:category).where('user_id =' + session[:login_id].to_s)
    @categories = Category.where('user_id =' + session[:login_id].to_s)

    notice_string = ''
    notice_string += 'Add a cart first! ' if @carts.length == 0
    notice_string += 'Add a category first! ' if @categories.length == 0
    notice_string += 'Add a subcategory first! ' if @subcategories.length == 0
    notice_string += 'Add a product first! ' if @products.length == 0
    redirect_to purchases_path, notice: notice_string if notice_string != ''
  end

  def edit
    return unless check_permission

    @purchase = Purchase.find(params[:id])
    @purchase.current_user_id = session[:login_id]

    @carts =  Cart.where('user_id =' + session[:login_id].to_s)
    @products = Product.left_joins(subcategory: :category).where('user_id =' + session[:login_id].to_s)

    @subcategories = Subcategory.left_joins(:category).where('user_id =' + session[:login_id].to_s)
    @categories = Category.where('user_id =' + session[:login_id].to_s)

    redirect_to  purchases_path, notice: 'error, purchase does not exist' unless @purchase

    # workaround for no auto-validation on this action
    redirect_to  purchases_path, notice: @purchase.errors.full_messages.join(', ') unless @purchase.valid?
  end

  def create # nowy wydatek - akcja
    return unless check_permission

    @purchase = Purchase.new(purchase_params)
    @purchase.current_user_id = session[:login_id]

    @carts =  Cart.where('user_id =' + session[:login_id].to_s)
    @products = Product.left_joins(subcategory: :category).where('user_id =' + session[:login_id].to_s)

    @subcategories = Subcategory.left_joins(:category).where('user_id =' + session[:login_id].to_s)
    @categories = Category.where('user_id =' + session[:login_id].to_s)

    if @purchase.save
      redirect_to @purchase.cart
    else
      puts @purchase.errors.inspect
      render 'new'
    end
  end

  def update
    return unless check_permission

    @purchase = Purchase.find(params[:id])
    @purchase.current_user_id = session[:login_id]

    @carts =  Cart.where('user_id =' + session[:login_id].to_s)
    @products = Product.left_joins(subcategory: :category).where('user_id =' + session[:login_id].to_s)

    @subcategories = Subcategory.left_joins(:category).where('user_id =' + session[:login_id].to_s)
    @categories = Category.where('user_id =' + session[:login_id].to_s)
    if @purchase.update(purchase_params)
      # update sucessfull
      # redirect to cart the purchase belongs to
      redirect_to @purchase.cart
    else
      render 'edit'
    end
  end

  def destroy
    return unless check_permission

    @purchase = Purchase.find(params[:id])
    @purchase.destroy_cascade(session[:login_id])
    # @purchase.destroy

    redirect_to purchases_path
  end

  def hide
    return unless check_permission

    @purchase = Purchase.find(params[:id])

    # method from a model
    @purchase.hide(session[:login_id])

    # redirect_to subcategories_path
    redirect_to @purchase.cart
  end

  def unhide
    return unless check_permission

    @purchase = Purchase.find(params[:id])

    # method from a model
    @purchase.unhide(session[:login_id])

    # redirect_to subcategories_path
    redirect_to @purchase.cart
  end

  private

  def purchase_params
    params.require(:purchase).permit(:cart_id, :product_id, :amount, :price, :name)
  end
end
