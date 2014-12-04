class CreateDeliveredMeals < ActiveRecord::Migration
  def change
    create_table :delivered_meals do |t|
      t.string :name
      t.references :customer, index: true
      t.string :type

      t.timestamps
    end
    add_index :delivered_meals, :type
  end
end
