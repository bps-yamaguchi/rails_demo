class Item < ApplicationRecord
  AWERD_POINT_LIMITS = { "medicine" => 50, "food" => 100 }

  def award_point
    base_point = (price * 0.1)
    limit = AWERD_POINT_LIMITS[category]
    if limit&.<base_point
      limit
    else
      base_point
    end
  end

  def no_discount
    category == "tobacco"
  end
end
