class Warehouse < ApplicationRecord
	include Filterable

	validates :name, :cod, :city, :cep, :address, :area, :description, presence: true
	validates :cod, :name, uniqueness: true
	validates :cod, length: {is: 3}
	validates :cep, format: {with: /\d{5}-\d{3}/}
	has_many :stock_products

	def full_description
		"#{name} | #{cod}"
	end

	scope :filter_by_name, -> (name) do
		where("name like ?", "%#{name.capitalize}%")
	end

	scope :filter_by_cod, -> (cod) do
		where(cod: cod.upcase)
	end

	scope :filter_by_city, -> (city) do
		where(city: city)
	end
end
