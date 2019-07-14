require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    let!(:user) { create(:user) }
    before do
      sign_in user
    end
    context 'index' do
      let(:user) { create(:user) }
      it 'expect populates an array of user' do
        get :index
        expect(assigns(:users)).to eq([user])
      end

      it 'expect renders the :index view' do
        get :index
        expect(response).to render_template('index')
      end
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }
    before do
      sign_in user
    end
    context 'show' do
      it 'expect assigns the requested user to @user' do
        get :show, params: { id: user.id }
        expect(assigns(:user)).to eq(user)
      end

      it 'expect renders the #show view' do
        get :show, params: { id: user.id }
        expect(response).to render_template('show')
      end
    end
  end

  describe 'GET #followers' do
    def do_request
      get :followers, params: { id: user.id }
    end
    let(:user) { create(:user) }
    before do
      sign_in user
    end
    context 'followers' do
      it 'expect assigns the requested user to @user' do
        do_request
        expect(assigns(:user)).to eq(user)
      end
      it 'expect renders the #followers view' do
        do_request
        expect(response).to render_template('follower')
      end
    end
  end

  describe 'GET #following' do
    def do_request
      get :following, params: { id: user.id }
    end
    let(:user) { create(:user) }
    before do
      sign_in user
    end

    context 'following' do
      it 'expect assigns the requested user to @user' do
        do_request
        expect(assigns(:user)).to eq(user)
      end
      it 'expect renders the #following view' do
        do_request
        expect(response).to render_template('following')
      end
    end
  end

  describe 'search' do
    let(:user) { create(:user) }
    it 'return the users match with search query' do
      sign_in user
      get :search, params: { search: { user_name: user.user_name} }
      expect(assigns(:users)).to eq([user])
    end
  end
end
