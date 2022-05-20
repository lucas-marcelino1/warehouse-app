class Order < ApplicationRecord
  belongs_to :supplier
  belongs_to :warehouse
  belongs_to :user
  validates :code, :estimated_delivery_date, presence: true
  before_validation :set_code
  validate :estimated_delivery_date_is_future

  private

  def set_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def estimated_delivery_date_is_future
    if self.estimated_delivery_date.present? && self.estimated_delivery_date <= Date.today
      self.errors.add(:estimated_delivery_date, "deve ser futura")
    end
  end

end
