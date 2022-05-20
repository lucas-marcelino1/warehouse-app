class Warehouse < ApplicationRecord
	validates :name, :cod, :city, :cep, :address, :area, :description, presence: true
	validates :cod, :name, uniqueness: true
	validates :cod, length: {is: 3}
	validates :cep, format: {with: /\d{5}-\d{3}/}

	def full_description
		"#{name} | #{cod}"
	end
end
