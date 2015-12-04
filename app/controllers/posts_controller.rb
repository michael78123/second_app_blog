class PostsController < ApplicationController
  before_action :find_group
  def new
    @post = @group.posts.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = @group.posts.build(post_params)

    if @post.save
      redirect_to group_path(@group), notice: "Successfully create new post!"
    else
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to group_path(@group), notice: "Successfully Editted!"
    else
      render :edit
    end
  end

  def destroy
    @post = @group.posts.find(params[:id])
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
end
