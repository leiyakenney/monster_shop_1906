class OrdersController <ApplicationController

  def new
    @user = current_user
    @order = Order.new
    @addresses = @user.addresses
  end

  def cancel
    order = Order.find(params[:id])
    order.cancel_order
    order.update(status: 3)
    order.save

    flash[:success] = "Your order has been cancelled"
    redirect_to "/profile"
  end

  def create
    @user = current_user
    @address = Address.find(params[:address])
    @order = Order.create(name: @user.name, address: @address)
    if @order.save
      cart.items.each do |item,quantity|
        @user.item_orders.create({
          order: @order,
          item: item,
          quantity: quantity,
          price: item.price
          })
      end
      session.delete(:cart)
      flash[:order] = "Your order has been created!"
      redirect_to "/profile/orders"
    else
      flash[:notice] = "Please complete address form to create an order."
      render :new
    end
  end

  private
  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
