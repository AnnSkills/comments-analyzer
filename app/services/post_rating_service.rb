class PostRatingService
  def initialize(comments)
    @comments = comments
  end

  def rate_post
    return 0 if @comments.empty?

    sum = @comments.sum(:rate)
    sum / @comments.size
  end
end
