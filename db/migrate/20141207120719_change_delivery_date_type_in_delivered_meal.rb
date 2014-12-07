class ChangeDeliveryDateTypeInDeliveredMeal < ActiveRecord::Migration
  def self.up 
    # change_column :delivered_meals, :delivery_date, :datetime 
  end

  def self.down
    # change_column :delivered_meals, :delivery_date, :string
  end
end
