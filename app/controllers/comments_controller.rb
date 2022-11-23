class CommentsController < ApplicationController
  def index
    @comments = Comment.where(post_id: comments_params)
  end

  private

  def comments_params
    params.require(:post_id)
  end
end
