class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts
  end

  def new
    @group = Group.new
  end

  def edit
    @group = current_user.groups.find(params[:id])
  end

  def create
    # 資料庫裡面的Group
    @group = current_user.groups.create(group_params)

    if @group.save
      current_user.join!(@group)
      redirect_to groups_path, notice:'Successfully created new board!'
    else
      flash[:alert] = 'The title can not be blank!'
      render :new
    end
  end

  def update
    @group = current_user.groups.find(params[:id])

    if @group.update(group_params)
      redirect_to groups_path, notice:'Successfully editted the board!'
    else
      render :edit
    end
  end

  def destroy
    @group = current_user.groups.find(params[:id])
    @group.destroy
    redirect_to groups_path, alert:'Successfully deleted the board!'
  end

  def join
    @group = Group.find(params[:id])
    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "You have successfully joined this group!"
    else
      flash[:warning] = "You are already the member of this group!"
    end
    redirect_to group_path(@group)
  end

  def quit
    @group = Group.find(params[:id])
    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:notice] = "You have successfully left the group!"
    else
      flash[:warning] = "You were not the member of this group, so how do you quit the group lol"
    end
    redirect_to group_path(@group)
  end
  private

  def group_params
    params.require(:group).permit(:title, :description)
  end
end
