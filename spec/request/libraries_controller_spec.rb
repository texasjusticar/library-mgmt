require "rails_helper"

RSpec.describe LibrariesController, type: :request do
  let(:auth_user) { create(:librarian) }
  let(:auth_header) { { "AUTHORIZATION" => "Bearer #{auth_user.auth_token}" } }
  let(:main_header) { { "CONTENT_TYPE" => "application/json" } }
  let(:all_headers) { main_header.merge!(auth_header) }

  describe 'without an authenticated user' do
    it 'returns a 401' do
      post libraries_path, params: { library: { name: 'Alexandria' } }, :headers => main_header
      expect(response.status).to eq(401)
    end
  end

  describe 'with authenticated user' do
    it "creates a library" do
      post libraries_path, params: { library: { name: 'Alexandria' } }.to_json, :headers => all_headers
      expect(JSON.parse(response.body)['name']).to eq('Alexandria')
    end
  end
end
