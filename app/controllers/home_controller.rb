class HomeController < ApplicationController

    def index
        @warehouses = Warehouse.filter(params.slice(:name, :cod, :city))
    end

end