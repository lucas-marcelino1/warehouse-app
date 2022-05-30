class ProductModel < ApplicationRecord
  belongs_to :supplier
  has_many :order_items
  has_many :orders, through: :order_items
  validates :name, :sku, :weight, :width, :height, :depth, presence: true
  validates :sku, length: {in: 20..20, message: 'deve conter 20 caracteres'}
  validates :sku, uniqueness: true
  validates :weight, :width, :height, :depth, comparison: {greater_than: 0, message: 'deve ser maior que 0'} 
end
