class CreateSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_table :suppliers do |t|
      t.string :corporation_name
      t.string :brand_name
      t.string :registration_number
      t.string :address
      t.string :city
      t.string :state
      t.string :email

      t.timestamps
    end
  end
end
