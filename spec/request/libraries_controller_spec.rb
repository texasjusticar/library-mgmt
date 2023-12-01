require "rails_helper"

RSpec.describe LibrariesController, type: :request do
  let(:auth_user) { create(:librarian) }
  let(:auth_header) { { "AUTHORIZATION" => "Bearer #{auth_user.auth_token}" } }
  let(:main_header) { { "CONTENT_TYPE" => "application/json" } }
  let(:all_headers) { main_header.merge!(auth_header) }
  let(:library) { create(:library) }
  let(:book) { create(:book) }

  describe 'without an authenticated user' do
    it 'returns a 401' do
      post libraries_path, params: { library: { name: 'Alexandria' } }, headers: main_header
      expect(response.status).to eq(401)
    end
  end

  describe 'with authenticated user' do
    it "creates a library" do
      post libraries_path, params: { library: { name: 'Alexandria' } }.to_json, headers: all_headers
      expect(JSON.parse(response.body)['name']).to eq('Alexandria')
    end

    it "will return an error if the library is lacking information" do
      post libraries_path, params: { library: { name: '' } }.to_json, headers: all_headers
      expect(response.status).to eq(422)
    end

    it "adds a book to a library" do
      post add_book_library_path(id: library.id), 
        params: {book: {author: book.author, title: book.title, isbn: book.isbn}}.to_json,
        headers: all_headers
      data = JSON.parse(response.body)
      expect(data['book']['isbn']).to eq(book.isbn)
      expect(data['library']['name']).to eq(library.name)
    end

    it "will return an error if the book is lacking information" do
      post add_book_library_path(id: library.id), 
        params: {book: {author: "nobody", title: "infinity", isbn: ''}}.to_json,
        headers: all_headers
      expect(response.status).to eq(422)
    end
  end
end
