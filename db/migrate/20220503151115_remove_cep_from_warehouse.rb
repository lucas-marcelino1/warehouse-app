class RemoveCepFromWarehouse < ActiveRecord::Migration[7.0]
  def change
    remove_column :warehouses, :CEP, :string
  end
end
