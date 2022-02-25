require 'rails_helper'

RSpec.describe RecsController, type: :controller do
  let!(:patient) { create(:patient) }
  let!(:rec) { create(:rec) }

  describe 'POST /rec' do
    context "with valid parameters" do
      let(:valid_params) do
        {
          rec: {
            patient_id: patient.id,
            rec_number: Faker::IDNumber.valid,
            valid_state: Faker::Address.state,
            physician_issuer: Faker::Address.state,
            url: Faker::Internet.url,
            exp_date: Faker::Date.forward(200)
          }
        }
      end

      it 'creates a new rec' do
        expect { post :create, params: valid_params }.to change(Rec, :count).by(+1)
        expect(response).to have_http_status :created
        expect(response.headers['Location']).to eq rec_url(Rec.last)
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
      get :show, params: { id: rec.id }
      expect(response).to have_http_status :ok
    end
  end

  describe 'PUT #update' do
    it 'tests update action' do
      put :update, params: { id: rec.id, rec: { rec_number: '123' } }
      expect(response).to be_successful
      expect(response).to have_http_status :accepted
    end
  end

  describe 'DELETE #destroy' do
    it 'tests destroy action' do
      delete :destroy, params: { id: rec.id }
      expect(response).to be_successful
      expect(response).to have_http_status :accepted
    end
  end

end
