class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(url: post_params[:url])
    parsing = ParsingService.new(@post.url)
    @post.name = parsing.scrap_title
    parsing.scrap_comments.each do |comment|
      sentiment = RapidApiService.new(comment).rapid_api_invoke
      @post.comments.insert_record(comment)
      @post.comments.rating = RatingService.new(sentiment['sentiment'], comment).rate_comment
      @post.rating = RatingService.new(sentiment['sentiment'], comment).rate_post
    end
    if @post.save
      format.html { redirect_to posts_path, notice: 'Post by url was successfully created.' }
    else
      format.html { render :new, status: :unprocessable_entity }
    end
  end

  private

  def post_params
    params.require(:post).permit(:url, :name, :comments, :rating)
  end
end
