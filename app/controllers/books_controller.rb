class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @new_book = Book.new
    @comment = BookComment.new
    @following_users = @user.followings
    @follower_users = @user.followers
  end

  def index
    @books = Book.includes(:favorited_users).where(favorites: { created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day }).sort { |a,b|b.favorited_users.size <=> a.favorited_users.size }
    @book = Book.new
    @user = current_user
    @following_users = @user.followings
    @follower_users = @user.followers
  end


  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end


  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

end