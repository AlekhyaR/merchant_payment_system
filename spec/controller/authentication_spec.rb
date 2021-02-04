require 'rails_helper'

describe 'Authentication', type: :request do
  describe 'POST /authenticate' do
    let(:merchant) { FactoryBot.create(:user) }

    it 'authenticates the merchant using his credentials' do
      m_user = FactoryBot.create(:user, name: 'Merchant123', password: 'Password1')
      post '/api/v1/authenticate', params: {name: m_user.name, password: m_user.password}

      expect(response).to have_http_status(:created)
    end

    it 'returns error when merchant name is missing' do
      post '/api/v1/authenticate', params: {password: 'Password1'}

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to eq({
        "error" => "param is missing or the value is empty: name"
      })
    end

    it 'returns error when merchant password is missing' do
      post '/api/v1/authenticate', params: {name: 'Merchant123'}

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to eq({
        "error" => "param is missing or the value is empty: password"
      })
    end

    it 'returns error when password is incorrect' do
      post '/api/v1/authenticate', params: {name: merchant.name, password: 'incorrect'}

      expect(response).to have_http_status(:unauthorized)
    end
  end
end