class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_order_by_name
  end
end
