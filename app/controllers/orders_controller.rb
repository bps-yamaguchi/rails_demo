class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:checkout, :cancel]

  def checkout
    @order = Order.checkout_from_cart(current_user.cart)

    if @order.persisted?
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  def cancel
    order = current_user.orders.find(params[:id])

    if order.cancel
      redirect_to order_path(order), notice: 'Your order has been cancelled successfully.'
    else
      redirect_to order_path(order), alert: 'There was a problem cancelling your order. Please try again.'
    end
  end

  private

  def authenticate_user!
    redirect_to login_path, alert: 'Please login to continue.' unless current_user
  end
end
