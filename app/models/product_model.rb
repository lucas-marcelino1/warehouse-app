class ProductModel < ApplicationRecord
  belongs_to :supplier
  validates :name, :sku, :weight, :width, :height, :depth, presence: true
  validates :sku, length: {in: 20..20}
  validates :sku, uniqueness: true
  validates :weight, :width, :height, :depth, comparison: {greater_than: 0}
end
