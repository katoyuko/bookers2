class UsersController < ApplicationController
    before_action :authenticate_user!
    # ログインの認証がされていなければrootパスへリダイレクト
    before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @book = Book.new
    #@booksには@userに紐づいた投稿(.books)のみを渡す
    @books = @user.books.page(params[:page]).reverse_order
  end

  def index
    # userの全てのデータを取り出す
    @users = User.all
    @user = current_user

    @book = Book.new
  end

  def edit
    @user = User.find(params[:id]) #form_for使用のためparams[:id]でユーザの情報を取得
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path(@user.id), notice: "Book was successfully updated."
    else
      render :edit
    end
  end

  #userストロングパラメータ
  private
def user_params
    params.require(:user).permit(:name, :introduction, :user_image)
end

  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to root_path
    end
  end

end