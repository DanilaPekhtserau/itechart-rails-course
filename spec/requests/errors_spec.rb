# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Errors', type: :request do
  describe 'GET /not_found' do
    it 'returns http success' do
      get '/errors/not_found'
      expect(response).to have_http_status(302)
    end
  end
end
