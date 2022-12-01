class CommentRatingService
  def initialize(sentiment)
    @sentiment = sentiment
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
end
