require 'rails_helper'

RSpec.descripe Post, type: :model do
  it 'post should have url' do
    expect(Post.new(name: 'Testing post')).to_not be_valid
  end

  it 'post should have name' do
    expect(Post.new(url: 'https://deadline.com/2022/11/death-in-paradise-our-house-itv-louise-candlish-red-planet-tony-jordan-1235162390')).to_not be_valid
  end

  it 'is not valid if the data is not filled' do
    Post.create(url: 'https://deadline.com/2022/11/death-in-paradise-our-house-itv-louise-candlish-red-planet-tony-jordan-1235162390', name: 'Testing post')
    expect(Post.count).to eq 1
  end

  it { should validate_uniqueness_of(:url).on(:create)  }

  it 'is comment added to post' do
    post_test = Post.create(url: 'https://deadline.com/2022/11/death-in-paradise-our-house-itv-louise-candlish-red-planet-tony-jordan-1235162390', name: 'Post name test')
    Comment.create(text: 'Comment one for test post', post_id: post.id)

    expect(post_test.comments.size).to eq 1
  end
end
