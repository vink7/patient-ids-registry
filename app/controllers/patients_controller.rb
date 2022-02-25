class PatientsController < ApplicationController
  before_action :find_patient, except: [:new, :create, :index]

  def new
    @patient = Patient.new
    @patient.build_identification
    @patient.build_rec
  end

  def create
    permitted_params = FileHelper.upload_files(patient_params)
    @patient = Patient.new(permitted_params)

    if @patient.save!
      head :created, location: patient_url(@patient)
    else
      head :unprocessable_entity
    end
  end

  def index
    @patients = Patient.all
    render json: @patients.to_json(:include => :identification, :methods => [:id_expired?, :rec_expired?])
  end

  def show
    render json: @patient.to_json(:include => :identification)
  end

  def update
    if @patient.update(patient_params)
      head :accepted
    else
      head :unprocessable_entity
    end
  end

  def destroy
    @patient.destroy
    head :accepted
  end

  private

  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :email, :dob,
                                    identification_attributes: [:id_number, :state_issuer, :exp_date, :file, :_destroy ],
                                    rec_attributes: [:rec_number, :valid_state, :physician_issuer, :exp_date, :file, :_destroy ])
  end

  def find_patient
    begin
      @patient = Patient.find(params[:id])
    rescue
      render json: { message: 'Patient not found' }, status: :unprocessable_entity
    end
  end

end
