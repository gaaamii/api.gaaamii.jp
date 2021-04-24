class PostsController < ApplicationController
  skip_before_action :require_admin_login, only: [:index, :show]

  def index
    @posts = Post.list
    render json: @posts
  end

  def show
    @post = Post.find(params[:id])
    render json: @post
  end

  def create
    Post.create!(post_params)
    head :created
  end

  def update
    post = Post.find(params[:id])
    post.update!(post_params)
    head :ok
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy!
    head :no_content
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :published_at)
  end
end
