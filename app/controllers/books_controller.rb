class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def new
  end

  def index
    @user=current_user
    @books=Book.all
    @book=Book.new
  end

  def show
    @newbook=Book.new
    @book=Book.find(params[:id])
    @user=@book.user
    @books=Book.all
  end

  def edit
    @book=Book.find(params[:id])
  end

  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    @book.save
    if @book.update(book_params)
      flash[:notice]="You have creatad book successfully."
      redirect_to book_path(@book.id)
    else
      @user=current_user
      @books=Book.all
      render :index
    end
  end

  def update
    @book=Book.find(params[:id])
    @book.user_id=current_user.id
    if @book.update(book_params)
      flash[:notice]="Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render "edit"
    end
  end

  def destroy
    @book=Book.find(params[:id])
    if @book.destroy
      flash[:notice]="Book was successfully destroyed."
      redirect_to books_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    if current_user != @user
      redirect_to books_path
    end
  end
end

