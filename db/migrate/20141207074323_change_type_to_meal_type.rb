class ChangeTypeToMealType < ActiveRecord::Migration
  def change
    rename_column :delivered_meals, :type, :meal_type
  end
end
