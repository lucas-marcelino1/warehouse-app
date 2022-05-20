class Supplier < ApplicationRecord
    has_many :product_models
    validates :corporation_name, :registration_number, :city, :state, :address, :email, presence: true
    validates :registration_number, uniqueness: true
    validates :registration_number, format: {with: /\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2}/, message: 'deve ter o formato XY.XYZ.XYZ/XYZA-XYZ'}

    def full_description
        "#{corporation_name} - #{brand_name} | #{registration_number}"
    end

end
