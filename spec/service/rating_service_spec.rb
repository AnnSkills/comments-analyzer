require 'rails_helper'

  describe PostRatingService, type: :model do
  describe '#rate_post' do
    it 'should return numeric rate of post' do
      post_test = Post.new(name: 'TEST', url: 'https://deadline.com/2022/11/death-in-paradise-our-house-itv-louise-candlish-red-planet-tony-jordan-1235162390')
      test_comments = [Comment.create(text: 'Good post!', post_id: post_test.id), Comment.create(text: 'Good bad!', post_id: post_test.id)]
      scraping = ScrapingService.new(post_test)
      post_test.rating = PostRatingService.new(scraping.scrape, test_comments).rate_post
      expect(post_test.rating).to be_kind_of Numeric
    end
  end

  describe '#rate_comment' do
    it 'should return 100 rate for comment' do
      post_test = Post.new(name: 'TEST', url: 'https://deadline.com/2022/11/death-in-paradise-our-house-itv-louise-candlish-red-planet-tony-jordan-1235162390')
      comment_test = Comment.create(text: 'WOW!', post_id: post_test.id)
      scraping = ScrapingService.new(post_test)
      comment_test.rate = PostRatingService.new(scraping.scrape, comment_test).rate_comment
      expect(comment_test.rate).to eq(100)
    end
  end
end
