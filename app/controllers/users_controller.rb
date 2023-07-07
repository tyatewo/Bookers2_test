class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end



  def show
    @user = User.find(params[:id])
    @users = User.all
    @book_new = Book.new
    @books = @user.books
    #投稿数を日付別に表示する方法
    @today_book = @books.created_today #(created_todayはbookモデルに定義している)
    @yesterday_book = @books.created_yesterday #(created_yesterdayはbookモデルに定義している)
    @this_week_book = @books.created_this_week #(created_todayはbookモデルに定義している)
    @last_week_book = @books.created_last_week #(created_yesterdayはbookモデルに定義している)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

 def search
    @user_books = User.find(params[:user_id]).books #user_idで取得したユーザの本の一覧を取得
    @created_time = params[:created_at] #created_atをcreated_timeに代入
    if @created_time == ""
      @search_book = "日付が選択されていません"
    else
      @search_book = @user_books.where(created_at: @created_time.to_date.all_day).count
    end
 end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end
