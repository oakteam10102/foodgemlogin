class RemakeDeliveryTimeInDeliveredMeal < ActiveRecord::Migration
  def self.up 
    remove_column :delivered_meals, :delivery_date
    add_column :delivered_meals, :delivery_date, :datetime
  end

  def self.down
    remove_column :delivered_meals, :delivery_date
    add_column :delivered_meals, :delivery_date, :datetime
  end
end
