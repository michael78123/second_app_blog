class PostsController < ApplicationController
  before_action :find_group
  before_action :authenticate_user!
  before_action :member_required, only: [:new, :create]
  def new
    @post = @group.posts.new
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def create
    @post = @group.posts.build(post_params)
    @post.author = current_user

    if @post.save
      redirect_to group_path(@group), notice: "Successfully create new post!"
    else
      render :new
    end
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to group_path(@group), notice: "Successfully Editted!"
    else
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to group_path(@group), alert: "Successfully deleted!"

  end

private
  def find_group
    @group = Group.find(params[:group_id])
  end
  def post_params
    params.require(:post).permit(:content)
  end
  def member_required
    if !current_user.is_member_of?(@group)
      flash[:warning] = "You are not the member of the group, can't create posts!"
      redirect_to group_path(@group)
    end
  end
end
