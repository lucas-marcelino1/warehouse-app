class AddColumnsToWarehouse < ActiveRecord::Migration[7.0]
  def change
    add_column :warehouses, :address, :string
    add_column :warehouses, :CEP, :string
    add_column :warehouses, :description, :string
  end
end
