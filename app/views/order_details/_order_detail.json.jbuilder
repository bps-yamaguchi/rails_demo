json.extract! order_detail, :id, :order_id, :item, :belongs_to, :amount, :created_at, :updated_at
json.url order_detail_url(order_detail, format: :json)
