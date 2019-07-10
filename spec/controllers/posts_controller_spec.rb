require 'rails_helper'
require 'spec_helper'

RSpec.describe PostsController, type: :controller do
  describe 'GET #index' do
    let(:user) { create :user }
    let(:post) { create :post, user: user }

    it 'expect populates an array of post' do
      sign_in user
      get :index
      expect(assigns(:posts)).to eq([post])
    end

    it 'expect renders the :index view' do
      sign_in user
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    let(:user) { create :user }
    let(:post) { create :post, user: user }
    it 'expect assigns the requested post to @post' do
      sign_in post.user
      get :show, params: { id: post.id }
      expect(assigns(:post)).to eq(post)
    end

    it 'expect renders the #show view' do
      sign_in post.user
      get :show, params: { id: post.id }
      expect(response).to render_template('show')
    end
  end

  describe 'GET #new' do
    it 'expect render new template' do
      user = create(:user)
      sign_in user
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe 'POST #create' do
    let(:user) { create :user }
    let(:new_post) { create :post, user: user }
    it "expect return a new post" do
      sign_in user
      expect(Post).to receive(:new).and_return(new_post)
      post :create, params: { post: { content: new_post.content, photo: 'photo.jpg' } }
      expect(assigns[:post].attributes).to eq(new_post.attributes)
    end

    it 'expect redirect to the post path after create new post success' do
      sign_in user
      expect(Post).to receive(:new).and_return(new_post)
      post :create, params: { post: { content: new_post.content, photo: 'photo.jpg' } }
      expect(response).to redirect_to Post.last
    end
  end

  describe 'GET #edit' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }
    it 'render edit view' do
      sign_in user
      get :edit, params: { id: post.id }
      expect(response).to render_template('edit')
    end
  end

  describe 'PUT #update' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }
    it 'expect return the post edited' do
      sign_in user
      put :update, params: { id: post.id, post: { content: 'new content' } }
      post.reload
      expect(post.content).to eq 'new content'
    end

    it 'expect redirect to the post path after edit success' do
      sign_in user
      put :update, params: { id: post.id, post: { content: 'new content' } }
      post.reload
      expect(response).to redirect_to Post.find(post.id)
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }
    it 'expect remove post from table posts' do
      sign_in user
      delete :destroy, params: { id: post.id }
      expect(Post.count).to be == 0
    end

    it 'expect redirect to post index after destroy post' do
      sign_in user
      delete :destroy, params: { id: post.id }
      expect(response).to redirect_to Post
    end
  end

  describe 'POST #like' do
    def do_request
      post :like, params: { id: target_post.id, format: :js }
    end

    let!(:user) { create(:user) }
    let!(:target_post) { create(:post) }

    before do
      sign_in user
    end

    context 'liked' do
      let!(:like) { create(:like, user: user, post: target_post) }

      it 'does not change like count' do
        expect { do_request }.not_to change{ Like.count }
      end

      it 'response correct layout and format' do
        do_request
        expect(response.content_type).to eq('text/javascript')
        expect(response).to render_template('like')
      end
    end

    context 'did not like' do
      it 'change like count' do
        expect { do_request }.to change { Like.count }.by(1)
      end

      it 'response correct layout and format' do
        do_request
        expect(response.content_type).to eq('text/javascript')
        expect(response).to render_template('like')
      end
    end
  end

end
