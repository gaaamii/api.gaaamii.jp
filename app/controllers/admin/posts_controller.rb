module Admin
  class PostsController < ApplicationController
    def index
      @posts = query_posts
      render json: @posts
    end

    def show
      post = Post.find(params[:post_id])
      render json: post
    end

    private

    def query_posts
      posts = case params[:status]
              when 'draft'
                Post.draft
              when 'published'
                Post.published
              else
                Post.all
              end

      posts.order(created_at: :desc)
    end
  end
end
