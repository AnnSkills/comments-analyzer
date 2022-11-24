require 'rails_helper'

describe ScrapingService, type: :model do
  describe '#rate_comment' do
    it 'should return rate of comment' do
      post_test = Post.new(name: 'TEST', url: 'https://deadline.com/2022/11/death-in-paradise-our-house-itv-louise-candlish-red-planet-tony-jordan-1235162390')
      comment_test = Comment.create()
      scaping = ScrapingService.new(post_test)
      post_test.rating = RatingService.new(scaping.scrape, comment_test)
      expect(post_test.rating).to include('')
    end
  end
end
