class PostsController < ApplicationController
  skip_before_action :require_admin_login, only: [:index, :show]

  def index
    @posts = Post.order(created_at: :desc)
    render json: @posts
  end

  def show
    @post = Post.find(params[:post_id])
    render json: @post
  end

  def create
    Post.create!(post_params)
    head :created
  end

  def update
    post = Post.find(params[:post_id])
    post.update!(post_params)
    head :ok
  end

  def destroy
    post = Post.find(params[:post_id])
    post.destroy!
    head :no_content
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :published_at)
  end
end
