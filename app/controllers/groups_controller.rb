class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.users << current_user         #@group.usersに、current_userを追加している
    if @group.save
      redirect_to groups_path
    else
      render 'new'
    end
  end

  def index
    @user = current_user
    @book = Book.new
    @groups = Group.all
  end

  def show
    @user = current_user
    @book = Book.new
    @group = Group.find(params[:id])
  end

  def join
    @group = Group.find(params[:group_id])
    @group.users << current_user         #@group.usersに、current_userを追加している
    redirect_to  groups_path
  end

  def edit

  end

  def update
    if @group.update(group_params)
      redirect_to groups_path
    else
      render "edit"
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.users.delete(current_user)  #current_userは、@group.usersから消されるという記述。
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
end
