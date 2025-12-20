class PostsController < ApplicationController
  skip_before_action :require_admin_login_by_sorcery, only: [:index, :show]

  def index
    @posts = Post.list
    render json: @posts
  end

  def show
    @post = Post.published.find(params[:id])
    render json: @post
  end

  def create
    post = Post.create!(post_params)
    request_to_revalidate_page(post.id)
    head :created
  end

  def update
    post = Post.find(params[:id])
    post.update!(post_params)
    request_to_revalidate_page(post.id)
    head :ok
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy!
    head :no_content
  end

  private

  def request_to_revalidate_page(post_id)
    url = "#{ENV['BLOG_SERVER_ORIGIN']}/api/revalidate?post_id=#{post_id}&secret=#{ENV['BLOG_SERVER_SECRET']}"
    Rails.logger.info "Revalidate request to #{url}"
    response = Net::HTTP.get_response(URI.parse(url))
    response.value
    Rails.logger.info "Revalidation succeeded."
  rescue => e
    Rails.logger.error 'Post revalidation failed.'
    Rails.logger.error e
  end

  def post_params
    params.require(:post).permit(:title, :body, :published_at, :status)
  end
end
