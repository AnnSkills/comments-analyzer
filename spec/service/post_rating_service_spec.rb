require 'rails_helper'

  describe PostRatingService, type: :model do
  describe '#rate_post' do
    it 'should return numeric rate of post' do
      post_test = Post.new(name: 'TEST', url: 'https://deadline.com/2022/12/peter-bart-pre-woke-royals-reveled-in-hollywood-naughtiness-1235188791/')
      test_comments = [Comment.create(text: 'Good post!', post_id: post_test.id, rate: 100), Comment.create(text: 'Bad post!', post_id: post_test.id, rate: -100)]
      post_test.rating = PostRatingService.new(test_comments).rate_post
      expect(post_test.rating).to eq(0)
    end
  end
end
