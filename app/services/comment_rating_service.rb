class CommentRatingService
  def initialize(compound)
    @compound = compound
  end

  def rate_comment
    @compound * 100
  end
end
