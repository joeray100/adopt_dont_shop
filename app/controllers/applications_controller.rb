class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:adopt] && !@application.pets.include?(Pet.find(params[:adopt]))
      @adopted_pets = @application.adopted_pets(Pet.find(params[:adopt]))
    elsif params[:search]
      @pet_search = Pet.partial_search(params[:search])
    end
  end

  def new
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = "ERROR: Missing required information!"
      render :new
    end
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :description, :status)
  end
end
