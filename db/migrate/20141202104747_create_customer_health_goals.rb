class CreateCustomerHealthGoals < ActiveRecord::Migration
  def change
    create_table :customer_health_goals do |t|
      t.integer :health_goal_id
      t.integer :customer_id
      t.timestamps
    end
  end
end
