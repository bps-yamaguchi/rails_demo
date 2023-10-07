class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :cancel]

  def create
    # ユーザーのカート情報を取得
    cart_items = current_user.cart.items

    # カートが空でないかチェック
    if cart_items.empty?
      redirect_to cart_path, alert: 'Your cart is empty. Please add items before checkout.'
      return
    end

    # OrderとOrderDetailを作成
    order = current_user.orders.build
    cart_items.each do |item|
      order.order_details.build(item: item, amount: item.amount)
    end

    # 保存とカートのクリア
    if order.save
      current_user.cart.items.clear
      redirect_to order_path(order), notice: 'Your order has been placed successfully.'
    else
      redirect_to cart_path, alert: 'There was a problem placing your order. Please try again.'
    end
  end

  def cancel
    # 指定されたIDのOrderを取得
    order = current_user.orders.find(params[:id])

    # Orderをキャンセル（実際のキャンセルロジックはモデル内で定義）
    if order.cancel
      redirect_to order_path(order), notice: 'Your order has been cancelled successfully.'
    else
      redirect_to order_path(order), alert: 'There was a problem cancelling your order. Please try again.'
    end
  end

  private

  # ユーザーがログインしているかをチェック
  def authenticate_user!
    redirect_to login_path, alert: 'Please login to continue.' unless current_user
  end
end
