class Admin::ApplicationsController < ApplicationsController
  def show
    @application = Application.find(params[:id])
    @pending_apps = Application.pending_apps
  end

  def update
    application = Application.find(params[:id])
    application.status = params[:status]
    application.save!
    redirect_to admin_application_path(application)
  end
end
