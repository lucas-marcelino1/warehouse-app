class StockProduct < ApplicationRecord
  belongs_to :warehouse
  belongs_to :order
  belongs_to :product_model
  before_validation :set_serial_number, on: :create

  def set_serial_number
    array_serial_number = Array.new(20) { SecureRandom.random_number(0..9) }
    string_serial_number = array_serial_number.join
    self.serial_number = string_serial_number
  end
end
