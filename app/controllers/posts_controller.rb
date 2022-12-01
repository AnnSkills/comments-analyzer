class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(url: post_params[:url])
    if !@post.save
      ScrapingService.new(@post).scrape
      redirect_to posts_path, notice: 'Post by url was successfully created.'
    else
      format.html { render :new, status: :unprocessable_entity }
    end
  end

  private

  def post_params
    params.require(:post).permit(:url)
  end
end
