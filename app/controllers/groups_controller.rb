class GroupsController < ApplicationController
  def index
    @groups = Group.all
    # flash[:notice] = "good morning!"
    # flash[:alert] = "time to sleep!"
    # flash[:warning] = "warning message!"
  end
  def show
    @group = Group.find(params[:id])
    @posts = @group.posts
  end

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    # 資料庫裡面的Group
    @group = Group.create(group_params)

    if @group.save
      redirect_to groups_path, notice:'Successfully created new board!'
    else
      flash[:alert] = 'The title can not be blank!'
      render :new
    end
  end

  def update
    @group = Group.find(params[:id])

    if @group.update(group_params)
      redirect_to groups_path, notice:'Successfully editted the board!'
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path, alert:'Successfully deleted the board!'
  end

  private

  def group_params
    params.require(:group).permit(:title, :description)
  end
end
