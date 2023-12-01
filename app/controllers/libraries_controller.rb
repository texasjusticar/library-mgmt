class LibrariesController < ApplicationController

  def create
    @library = Library.create(library_params)
  end

  private
  def library_params
    params.require(:library).permit(:name)
  end
end