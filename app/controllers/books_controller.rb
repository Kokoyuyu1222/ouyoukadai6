class BooksController < ApplicationController
  before_action :authenticate_user!

  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  def show
  	@book = Book.find(params[:id])
    @book_new = Book.new
    @user = User.find(@book.user_id)
    @comment = BookComment.new
    @comments = @book.book_comments
    @favorite = Favorite.new
  end

  def index
  	@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
    @book = Book.new
    @user = current_user
  end

  def create
  	@book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    @book.user_id = current_user.id
    @user = current_user
    @books = Book.all
  	if @book.save #入力されたデータをdbに保存する。
  		redirect_to book_path(@book.id), notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
  		render 'index'
  	end
  end

  def edit
  	@book = Book.find(params[:id])
  end



  def update
  	@book = Book.find(params[:id])
    @book.user_id = current_user.id
  	if @book.update(book_params)
  		redirect_to book_path, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end
  def user_params
  params.require(:user).permit(:name, :introduction, :profile_image)
end
  def ensure_correct_user
  @book = Book.find_by(id: params[:id])
  if current_user.id != @book.user_id
    flash[:notice] = "権限がありません"
    redirect_to books_path
  end
end

end
