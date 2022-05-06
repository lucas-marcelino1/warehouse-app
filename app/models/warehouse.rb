class Warehouse < ApplicationRecord
	validates :name, :cod, :city, :cep, :address, :area, :description, presence: true
	validates :cod, uniqueness: true
end
