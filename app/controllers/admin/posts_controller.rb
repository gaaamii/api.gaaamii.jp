module Admin
  class PostsController < ApplicationController
    def index
      @posts = query_posts
      render json: @posts
    end

    private

    def query_posts
      case params[:status]
      when 'draft'
        Post.draft
      when 'published'
        Post.published
      else
        Post.all
      end
    end
  end
end
