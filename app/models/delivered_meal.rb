class DeliveredMeal < ActiveRecord::Base
  belongs_to :customer

  def to_s
    name
  end
end
