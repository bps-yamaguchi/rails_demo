class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details

  enum status: { pending: 0, shipped: 1, cancelled: 2 }

  validates :user, presence: true
  validates_associated :order_details

  def self.checkout_from_cart(cart)
    order = new(user: cart.user, status: :pending)

    ActiveRecord::Base.transaction do
      cart.items.each do |item|
        order.order_details.build(item: item, amount: item.amount)
      end

      order.save!

      PointLog.create!(user: order.user, points: order.points_to_add, trigger: order)
    end

    order
  rescue ActiveRecord::RecordInvalid
    order
  end

  def cancel
    update(status: :cancelled)
  end

  def point_to_add
    order.total_price * 0.1
  end

  def total_price
    items.sum { |item| item.price }
  end
end
