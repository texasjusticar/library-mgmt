class LibrariesController < ApplicationController
  before_action :load_library, except: :create

  def create
    @library = Library.create(library_params)
    render json: {error: @library.errors.full_messages}, status: 422 and return if @library.errors.any? 
  end

  def add_book
    @book = Book.find_or_create_by(book_params)
    if @book.errors.any?
      render json: {error: @book.errors.full_messages}, status: 422 and return
    else
      @library.books << @book
    end
  end

  private
  def library_params
    params.require(:library).permit(:name)
  end

  def book_params
    params.require(:book).permit(:title, :author, :isbn)
  end

  def load_library
    @library ||= Library.find_by(params[:library_id])
  end
end