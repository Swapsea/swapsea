# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'EventLogs' do
  describe 'GET /event_logs' do
    it 'works! (now write some real specs)' do
      get event_logs_path, params: nil
      expect(response).to have_http_status(:found)

      follow_redirect!
      expect(response).to have_http_status(:ok)
    end
  end
end
