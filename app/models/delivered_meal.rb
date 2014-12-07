class DeliveredMeal < ActiveRecord::Base
  belongs_to :customer

  def to_s
    name
  end

  def delivery_date_string
    delivery_date.strftime('%F') if delivery_date
  end
end
