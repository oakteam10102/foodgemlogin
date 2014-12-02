class CreateHealthGoals < ActiveRecord::Migration
  def change
    create_table :health_goals do |t|
      t.string :name

      t.timestamps
    end
  end
end
