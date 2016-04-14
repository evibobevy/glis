class VolunteersController < ApplicationController
  before_action :set_volunteer, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @volunteers = Volunteer.all
    respond_with(@volunteers)
  end

  def show
    respond_with(@volunteer)
  end

  def new
    @volunteer = Volunteer.new
    respond_with(@volunteer)
  end

  def edit
  end

  def create
    @volunteer = Volunteer.new(volunteer_params)
    @volunteer.save
    respond_with(@volunteer)
  end

  def update
    @volunteer.update(volunteer_params)
    respond_with(@volunteer)
  end

  def destroy
    @volunteer.destroy
    respond_with(@volunteer)
  end

  private
    def set_volunteer
      @volunteer = Volunteer.find(params[:id])
    end

    def volunteer_params
      params.require(:volunteer).permit(:name,:image)
    end
end
