class IdentificationsController < ApplicationController
  before_action :find_identification, except: [:new, :create, :index]

  def create
    @identification = Identification.new(identification_params)

    if @identification.save!
      head :created, location: identification_url(@identification)
    else
      head :unprocessable_entity
    end
  end

  def index
    render json: @identifications, status: :ok
  end

  def show
    render json: @identification, status: :ok
  end

  def update
    if @identification.update(identification_params)
      head :accepted
    else
      head :unprocessable_entity
    end
  end

  def destroy
    @identification.destroy
    head :accepted
  end

  private

  def identification_params
    params.require(:identification).permit(:id_number, :state_issuer, :exp_date, :url, :patient_id)
  end

  def find_identification
    @identification = Identification.find(params[:id])
  end

end
