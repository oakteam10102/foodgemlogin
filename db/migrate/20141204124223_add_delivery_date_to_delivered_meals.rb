class AddDeliveryDateToDeliveredMeals < ActiveRecord::Migration
  def change
    add_column :delivered_meals, :delivery_date, :string
  end
end
