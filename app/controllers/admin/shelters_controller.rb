class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_order_by_name
    @pending_app_shelters = Shelter.shelters_with_pending_apps
  end
end
