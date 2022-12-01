require 'rails_helper'

describe PostsController, type: :controller do
  describe 'GET index' do
    it 'assigns @posts' do
      post = Post.create
      get :index
      expect(assigns(:posts)).to eq([post])
    end
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET new' do
    it 'should assing @post' do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end

    it 'should render the new template with 200 status code' do
      get :new
      expect(response).to render_template('new')
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST create' do
    it 'should create new post with valid url' do
      post 'create', params: { post: { url: 'https://deadline.com/2022/11/death-in-paradise-our-house-itv-louise-candlish-red-planet-tony-jordan-1235162390' } }
      expect(Post.count).to eq 1
    end

    it 'should redirect to post_path with 302 status code after successful creating' do
      post 'create', params: { post: { url: 'https://deadline.com/2022/11/death-in-paradise-our-house-itv-louise-candlish-red-planet-tony-jordan-1235162390' } }
      expect(response).to redirect_to posts_path
      expect(response).to have_http_status(302)
    end

  end
end
