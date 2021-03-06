class BooksController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @book = Book.new
  end

  def create
    @user = User.find(current_user.id)
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = 'You have created book successfully.'
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
      flash[:notice] = 'You have updated book successfully.'
      redirect_to book_path(@book)
    else
      render :edit
    end
  end
  
  def index
    @q = Book.ransack(params[:q])
    @books = @q.result(distinct: true).all.order(params[:sort])
    @user = User.find(current_user.id)
    @book = Book.new
  end

  def show
    @user = User.find(current_user.id)
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body, :rate, :category,)
  end
  
end