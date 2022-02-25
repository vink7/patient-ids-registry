require 'rails_helper'

RSpec.describe PingController, type: :controller do
  describe '#ping' do
    it 'returns "pong"' do
      get :ping
      expect(response.code).to eq('200')
      expect(response.body).to eq('pong')
    end
  end
end
