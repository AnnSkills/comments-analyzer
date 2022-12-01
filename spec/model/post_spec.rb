require 'rails_helper'

describe Post do
  before(:each) do
    @attributes = {
      name: 'Testing post',
      url: 'https://deadline.com/2022/11/death-in-paradise-our-house-itv-louise-candlish-red-planet-tony-jordan-1235162390'
    }
  end

  it "should create new post with given valid attributes" do
    Post.create!(@attributes)
  end

  it 'post should have url' do
    post_without_url = Post.create(@attributes.merge(url: ''))
    expect(post_without_url).to_not be_valid
  end

  it 'post should have name' do
    post_without_name = Post.create(@attributes.merge(name: ''))
    expect(post_without_name).to_not be_valid
  end

  it "should reject duplicate post url" do
    post = Post.create(@attributes)
    post_with_duplicate_url = Post.create(@attributes)
    expect(post_with_duplicate_url.url).to_not equal(post.url)
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
