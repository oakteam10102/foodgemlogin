class AddPaymentStatusToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :payment_status, :string
    add_index :subscriptions, :payment_status
  end
end
