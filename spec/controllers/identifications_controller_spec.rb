require 'rails_helper'

RSpec.describe IdentificationsController, type: :controller do
  let!(:patient) { create(:patient) }
  let!(:identification) { create(:identification) }

  describe 'POST /identifications' do
    context "with valid parameters" do
      let(:valid_params) do
        {
          identification: {
            patient_id: patient.id,
            id_number: Faker::IDNumber.valid,
            state_issuer: Faker::Address.state,
            exp_date: Faker::Date.forward(200),
            url: Faker::Internet.url
          }
        }
      end

      it 'creates a new identification' do
        expect { post :create, params: valid_params }.to change(Identification, :count).by(+1)
        expect(response).to have_http_status :created
        expect(response.headers['Location']).to eq identification_url(Identification.last)
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
      get :show, params: { id: identification.id }
      expect(response).to have_http_status :ok
    end
  end

  describe 'PUT #update' do
    it 'tests update action' do
      put :update, params: { id: identification.id, identification: { id_number: '123' } }
      expect(response).to be_successful
      expect(response).to have_http_status :accepted
    end
  end

  describe 'DELETE #destroy' do
    it 'tests destroy action' do
      delete :destroy, params: { id: identification.id }
      expect(response).to be_successful
      expect(response).to have_http_status :accepted
    end
  end

end
