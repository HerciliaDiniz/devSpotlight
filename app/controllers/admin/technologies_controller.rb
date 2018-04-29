class Admin::TechnologiesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @technologies = Technology.order(name: :asc)
  end

  def new
    @technology = Technology.new
  end

  def create
    @technology = Technology.new

    if @technology.save
      redirect_to admin_technologies_path
    else
      render :new 
    end

  end

  def destroy
    @technology.destroy
    redirect_to admin_technologies_path
  end

  private
  def authorize_admin!
    unless current_user.permission_type == 3
      flas[:alert] = "Access Denied"
      redirect_to home_path
    end
  end
end
