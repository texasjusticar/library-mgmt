require "rails_helper"

RSpec.describe LibrariesController, type: :request do
  let(:auth_user) { create(:librarian) }
  let(:auth_header) { { "AUTHORIZATION" => "Bearer #{auth_user.auth_token}" } }
  let(:main_header) { { "CONTENT_TYPE" => "application/json" } }
  let(:all_headers) { main_header.merge!(auth_header) }
  
  let(:library) { create(:library) }
  let(:book) { create(:book) }
  let(:book_copy) { LibraryBookCopy.create(library_id: library.id, book_id: book.id)}
  let(:borrower) { create(:borrower) }
  
  let(:data) { JSON.parse(response.body) }

  describe 'without an authenticated user' do
    it 'returns a 401' do
      post libraries_path, params: { library: { name: 'Alexandria' } }, headers: main_header
      expect(response.status).to eq(401)
    end
  end

  describe 'with authenticated user' do
    context '#create' do
      it "creates a library" do
        post libraries_path, params: { library: { name: 'Alexandria' } }.to_json, headers: all_headers
        expect(JSON.parse(response.body)['name']).to eq('Alexandria')
      end

      it "will return an error if the library is lacking information" do
        post libraries_path, params: { library: { name: '' } }.to_json, headers: all_headers
        expect(response.status).to eq(422)
      end
    end

    context '#add_book' do
      it "adds a book to a library" do
        post add_book_library_path(id: library.id), 
          params: {book: {author: book.author, title: book.title, isbn: book.isbn}}.to_json,
          headers: all_headers

        expect(data['book']['isbn']).to eq(book.isbn)
        expect(data['library']['name']).to eq(library.name)
      end

      it "will return an error if the book is lacking information" do
        post add_book_library_path(id: library.id), 
          params: {book: {author: "nobody", title: "infinity", isbn: ''}}.to_json,
          headers: all_headers
        expect(response.status).to eq(422)
      end

      xit "will add another copy of an existing book to a library" do
      end
    end
  end

  context '#find_book' do
    let(:library2) { create(:library) }
    let(:book2) do 
      book_factory = create(:book, title: 'Inspiring Quotes')
      library2.books << book_factory
      book_factory
    end

    before do
      # seed book copies
      book_copy
      book2
    end

    it 'will find a book given a library' do
      get find_book_library_path(id: library2.id, token: 'inspiring'), headers: all_headers
      expect(data.first['copy_id']).to eq(book2.library_book_copies.first.id)
    end

    xit 'will not find a book from another library not scoped to the current one' do
    end

    it 'will find all books globally if provided no library' do
      get find_book_library_path(id: 0, token: 'content'), headers: all_headers
      expect(data.first['copy_id']).to eq(book.library_book_copies.first.id)
    end

    it 'will find the earliest book that will be available' do
      library.borrowers << borrower
      book_copy.library = nil
      book_copy.borrower_id = borrower.id
      book_copy.due_date = 4.days.since
      book_copy.save

      library2.borrowers << borrower
      library2.books << book

      book_copy2 = library2.books.first.library_book_copies.first
      book_copy2.library = nil
      book_copy2.borrower_id = borrower.id
      book_copy2.due_date = 2.days.since
      book_copy2.save

      get find_book_library_path(id: 0, token: 'content'), headers: all_headers
      expect(data.first['copy_id']).to eq(book_copy2.id)
    end
  end

  context '#register_borrower' do
    it 'will register a borrower to the current library' do
      post register_borrower_library_path(id: library.id),
        params: {
          borrower: {
            name: "Amos Barton",
            cc_number: "1111-2222-3333-4444",
            cc_expiration: "3/2266"
          }
        }.to_json,
        headers: all_headers

      expect(data['library']['name']).to eq(library.name)
      expect(data['borrower']['name']).to eq('Amos Barton')
    end

    it 'will error if there is not valid information' do
      post register_borrower_library_path(id: library.id),
        params: {
          borrower: {
            name: "Amos Barton",
            cc_number: "",
            cc_expiration: "3/2266"
          }
        }.to_json,
        headers: all_headers
      expect(response.status).to eq(422)
    end
  end

  context '#lend_book' do
    it 'will lend a book from the library' do
      put lend_book_library_path(id: library.id),
        params: {
          borrower_id: borrower.id,
          copy_id: book_copy.id,
        }.to_json,
        headers: all_headers

      expect(data["due_date"].to_date).to eq(7.days.since.to_date)
    end

    xit 'it will error if there are invalid data passed in' do
    end
  end
end
