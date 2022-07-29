class BooksController < ApplicationController
  before_action :correct_user, only: [:edit]
  def new
    @book = Book.new
  end

  # 投稿データの保存
   def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
      if @book.save
    redirect_to book_path(@book.id), notice: 'successfully'
      else
    @user = current_user
    @books = Book.all
    render :index
      end
   end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @new_book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
      if@book.update(book_params)
        redirect_to  book_path(@book.id), notice: 'successfully'

      else
        render :edit
      end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

   # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
  
end
