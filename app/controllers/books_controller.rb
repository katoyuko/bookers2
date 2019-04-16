class BooksController < ApplicationController
    before_action :authenticate_user!,except: [:home, :about]
    # ログインの認証がされていなければrootパスへリダイレクト（homeとabout以外）
    before_action :correct_user, only: [:edit, :update]

  def home
  end

  def about
  end

  def show   #1対1の関係を思い出す
    @book = Book.find(params[:id])
    @user = current_user
  end


  def index
    # 全てのデータを取り出す
    @books = Book.all
    # 空のモデルをビューへ渡す
    @book = Book.new
    @user = current_user
  end

  def create # 投稿データの保存
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "Book was successfully created."
    else
      @books = Book.all
      @user = current_user
      # 指定しないとvalidationが表示されない
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id]) #form_for使用のためparams[:id]で投稿の情報を取得
  end

    def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "Book was successfully updated."
    else
      render :edit
    end
  end


  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  #投稿データストロングパラメータ
  private
  def correct_user
    book = Book.find(params[:id])
    if current_user.id != book.user.id
      redirect_to root_path
    end
  end
  def book_params
    params.require(:book).permit(:title, :opinion)
  end

end
