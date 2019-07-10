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
    let(:user) { create(:user) }

    before do
      sign_in user
    end
    context 'followers' do
      it 'expect assigns the requested user to @user' do
        get :followers, params: { id: user.id }
        expect(assigns(:user)).to eq(user)
      end
    end
  end

  describe 'GET #following' do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    context 'following' do
      it 'expect assigns the requested user to @user' do
        get :following, params: { id: user.id }
        expect(assigns(:user)).to eq(user)
      end
    end
  end

end
