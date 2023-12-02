class LibrariesController < ApplicationController
  def create
    @library = Library.create(library_params)
    render json: {error: @library.errors.full_messages}, status: 422 and return if @library.errors.any? 
  end

  def add_book
    @book = Book.find_or_create_by(book_params)
    if @book.errors.any?
      render json: {error: @book.errors.full_messages}, status: 422 and return
    else
      library.books << @book
    end
  end

  def find_book
    scope = @library&.books || Book
    @books = scope.includes(:library_book_copies).
      where("LOWER(title) like '%#{params[:token].downcase}%'")
  end

  def register_borrower
    @borrower = Borrower.find_or_create_by(borrower_params)
    if @borrower.errors.any?
      render json: {error: @borrower.errors.full_messages}, status: 422 and return
    else
      library.borrowers << @borrower
    end
  end

  def lend_book
    unless borrower && library && book_copy
      render json: {error: "Unable to process, contact support #{[borrower&.id, library&.id, book_copy&.id].join('|') }"}, status: 422 and return 
    end
  
    book_copy.library_id = nil
    book_copy.borrower_id = borrower.id
    book_copy.due_date = 7.days.since
    book_copy.save
  end

  private
  def library_params
    params.require(:library).permit(:name)
  end

  def book_params
    params.require(:book).permit(:title, :author, :isbn)
  end

  def borrower_params
    params.require(:borrower).permit(:name, :cc_number, :cc_expiration)
  end

  def library
    @library ||= Library.find_by(id: params[:id])
  end

  def book_copy
    @book_copy ||= LibraryBookCopy.find_by(id: params[:copy_id])
  end

  def borrower
    @borrower ||= Borrower.find_by(id: params[:borrower_id])
  end
end