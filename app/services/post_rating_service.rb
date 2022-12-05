class PostRatingService
  def initialize(comments)
    @comments = comments
  end

  def rate_post
    return 0 if @comments.empty?

    sum = 0
      @comments.each do |comment|
        sum += comment.rate
      end
    sum / @comments.size
  end
end
