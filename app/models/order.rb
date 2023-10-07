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
      cart.cart_details.each do |cart_detail|
        order.order_details.build(item: cart_detail.item, amount: cart_detail.amount)
      end

      order.save!
      unless items.any?(:no_discount)
        PointLog.create!(user: order.user, points: order.points_to_add, trigger: order)
      end
    end

    order
  rescue ActiveRecord::RecordInvalid
    order
  end

  def cancel
    point_log = user.point_logs.find_by(trigger: self)
    point_log&.destroy
    update(status: :cancelled)
    point_log.notify_revoked
  end

  def point_to_add
    order_details.sum { |detail| detail.item.award_point * detail.amount }
  end

  def total_price
    order_details.sum { |detail| detail.item.price * detail.amount }
  end
end
