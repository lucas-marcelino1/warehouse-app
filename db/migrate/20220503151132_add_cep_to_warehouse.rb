class AddCepToWarehouse < ActiveRecord::Migration[7.0]
  def change
    add_column :warehouses, :cep, :string
  end
end
