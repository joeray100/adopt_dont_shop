class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
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
