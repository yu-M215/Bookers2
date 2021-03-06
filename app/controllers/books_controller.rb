class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id)
      flash[:notice] = "You have created book successfully."
    else
      @user = User.find(current_user.id)
      @books = Book.all
      render :index
    end
  end

  def index
    to = Time.current.at_end_of_day
    from  = (to - 6.day).at_beginning_of_day
    @user = User.find(current_user.id)
    @book = Book.new
    @books = Book.includes(:favorited_users).sort {|a, b|
      b.favorited_users.includes(:favorites).where(created_at: from...to).size <=>
      a.favorited_users.includes(:favorites).where(created_at: from...to).size
    }
  end

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @user = User.find(@book.user.id)
    @book_comment = BookComment.new

    # impressionistを利用した閲覧数のカウント
    # impressionist(@book, nil, unique: [:session_hash.to_s])

    unless ViewCount.find_by(user_id: current_user.id, book_id: @book.id)
      current_user.view_counts.create(book_id: @book.id)
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
        redirect_to book_path(@book.id)
        flash[:notice] = "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
