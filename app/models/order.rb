class Order < ApplicationRecord
  belongs_to :supplier
  belongs_to :warehouse
  belongs_to :user
  validates :code, presence: true
  before_validation :set_code

  private
  def set_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end
end
