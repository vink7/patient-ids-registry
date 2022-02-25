require 'rails_helper'

RSpec.describe CatchAllController, type: :controller do
  before do
    Rails.application.routes.draw do
      match '/invalid_path' => 'catch_all#index', via: :get
    end
  end

  after do
    Rails.application.reload_routes!
  end

  describe '#index' do
    it 'returns bad request' do
      get :index
      expect(response).to have_http_status(:bad_request)
    end
  end
end
