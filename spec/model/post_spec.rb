require 'rails_helper'

describe Post do
  before(:each) do
    @attributes = {
      :name => 'Testing post',
      :url => 'https://deadline.com/2022/11/death-in-paradise-our-house-itv-louise-candlish-red-planet-tony-jordan-1235162390'
    }
  end

  it "should create new post with given valid attributes" do
    Post.create!(@attributes)
  end

  it 'post should have url' do
    expect(Post.new(@attributes.merge(:url => ''))).to be_valid
  end

  it 'post should have name' do
    expect(Post.new(@attributes.merge(:name => ''))).to be_valid
  end

  it "should reject duplicate post url" do
    Post.create!(@attributes)
    user_with_duplicate_email = Post.new(@attributes)
    expect(user_with_duplicate_email).to be_valid
  end

  it 'is not valid if the data is not filled' do
    Post.create(url: 'https://deadline.com/2022/11/death-in-paradise-our-house-itv-louise-candlish-red-planet-tony-jordan-1235162390', name: 'Testing post')
    expect(Post.count).to eq 1
  end

  it 'is comment added to post' do
    post_test = Post.create(url: 'https://deadline.com/2022/11/death-in-paradise-our-house-itv-louise-candlish-red-planet-tony-jordan-1235162390', name: 'Post name test')
    Comment.create(text: 'Comment one for test post', post_id: post_test.id)
    expect(post_test.comments.size).to eq 1
  end
end
