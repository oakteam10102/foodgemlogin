class CreateOtherAllergies < ActiveRecord::Migration
  def change
    create_table :other_allergies do |t|
      t.text :description
      t.references :customer, index: true

      t.timestamps
    end
  end
end
