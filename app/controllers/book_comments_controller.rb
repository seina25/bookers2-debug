class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    if @comment.save
      render :index
    #else
      #@user = @book.user
      #@new_book = Book.new

      #render "books/show"
    end
  end

  def destroy
    if BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
        flash[:notice] = "You have updated user successfully."
         redirect_to book_path(params[:book_id])
    #else
         #redirect_back(fallback_location: root_path)
    end
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
