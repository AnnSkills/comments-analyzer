class RatingService
  def initialize(sentiment, comments)
    @sentiment = sentiment
    @comments = comments
  end

  def rate_comment
    case @sentiment
    when 'positive'
      100
    when 'neutral'
      0
    when 'negative'
      -100
    end
  end

  def rate_post
    sum = @comments.confidence.sum
    if @comments.size != 0
      sum / @comments.size
    else
      0
    end
  end
end
