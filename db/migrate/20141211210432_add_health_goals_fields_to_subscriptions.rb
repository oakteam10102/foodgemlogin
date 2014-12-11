class AddHealthGoalsFieldsToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :age, :integer
    add_column :subscriptions, :weight, :string
    add_column :subscriptions, :height, :string
    add_column :subscriptions, :caloric_target, :string
  end
end
