require 'rails_helper'

RSpec.describe PatientsController, type: :controller do
  let!(:patient) { create(:patient) }
  let!(:identification) { create(:identification, patient: patient) }
  let!(:rec) { create(:rec, patient: patient) }

  describe 'POST /patients' do
    context "with valid parameters" do
      let(:valid_params) do
        {
           patient: {
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            email: Faker::Internet.free_email,
            dob: Faker::Date.birthday,
            identification_attributes: {
              id_number: Faker::IDNumber.valid,
              state_issuer: Faker::Address.state,
              exp_date: Faker::Date.forward(200),
              file: fixture_file_upload('/weedmaps.png', 'image/png')
            },
            rec_attributes: {
              rec_number: Faker::IDNumber.valid,
              valid_state: Faker::Address.state,
              physician_issuer: Faker::Name.name,
              exp_date: Faker::Date.forward(200),
              file: fixture_file_upload('/weedmaps.png', 'image/png')
            }
          }
        }
      end

      it 'creates a new patient' do
        expect { post :create, params: valid_params }.to change(Patient, :count).by(+1)
        expect(response).to have_http_status :created
        expect(response.headers['Location']).to eq patient_url(Patient.last)
      end

    end

  end

  describe 'GET #index' do
    it 'tests index page content' do
      get :index
      expect(response).to have_http_status :ok
    end
  end

  describe 'GET #show' do
    it 'tests show page content' do
      get :show, params: { id: patient.id }
      expect(response).to have_http_status :ok
    end
  end

  describe 'PUT #update' do
    it 'tests update action' do
      put :update, params: { id: patient.id, patient: { first_name: 'jane' } }
      expect(response).to be_successful
      expect(response).to have_http_status :accepted
    end
  end

  describe 'DELETE #destroy' do
    it 'tests destroy action' do
      delete :destroy, params: { id: patient.id }
      expect(response).to be_successful
      expect(response).to have_http_status :accepted
    end
  end

end
