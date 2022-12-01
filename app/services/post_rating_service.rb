class PostRatingService
  def initialize(comments)
    @comments = comments
  end

  def rate_post
    sum = 0
    @comments.each do |comment|
      sum += comment.rate
    end
    if @comments.size != 0
      sum / @comments.size
    else
      0
    end
  end
end
