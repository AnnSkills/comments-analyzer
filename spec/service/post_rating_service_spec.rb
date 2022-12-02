require 'rails_helper'

  describe PostRatingService, type: :model do
  describe '#rate_post' do
    it 'should return numeric rate of post' do
      post_test = Post.new(name: 'TEST', url: 'https://deadline.com/2022/11/death-in-paradise-our-house-itv-louise-candlish-red-planet-tony-jordan-1235162390')
      test_comments = Comment.create(text: 'Good post!', post_id: post_test.id, rate: 100)
      post_test.rating = PostRatingService.new(test_comments).rate_post
      expect(post_test.rating).to be_kind_of Numeric
    end
  end
end
