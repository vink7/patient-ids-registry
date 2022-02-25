class RecsController < ApplicationController
  before_action :find_rec, except: [:new, :create, :index]

  def create
    @rec = Rec.new(rec_params)

    if @rec.save!
      head :created, location: rec_url(@rec)
    else
      head :unprocessable_entity
    end
  end

  def index
    render json: @rec, status: :ok
  end

  def show
    render json: @rec, status: :ok
  end

  def update
    if @rec.update(rec_params)
      head :accepted
    else
      head :unprocessable_entity
    end
  end

  def destroy
    @rec.destroy
    head :accepted
  end

  private

  def rec_params
    params.require(:rec).permit(:rec_number, :valid_state, :physician_issuer, :exp_date, :url, :patient_id)
  end

  def find_rec
    @rec = Rec.find(params[:id])
  end

end
