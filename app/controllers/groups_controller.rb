class GroupsController < ApplicationController

  before_action :correct_group, only: [:edit, :update]

  def index
    @groups = Group.all
    @book = Book.new
  end

  def show
    @group = Group.find(params[:id])
    @book = Book.new
  end

  def join
    @group = Group.find(params[:group_id])
    @group.users.push(current_user)
    # redirect_to  group_path(@group)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
    @group.users.push(current_user)
      redirect_to groups_path
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.users.delete(current_user)
    # redirect_to group_path(@group)
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end

  def correct_group
    group = Group.find(params[:id])
    unless current_user.id == group.owner_id
      redirect_to groups_path
    end
  end

end
