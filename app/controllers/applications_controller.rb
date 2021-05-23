class ApplicationsController < ApplicationController
  def show
    if params[:search]
      @application = Application.find(params[:id])
      @pet_search = Pet.partial_search(params[:search])
      @pets = @application.pets
    else
      @application = Application.find(params[:id])
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
