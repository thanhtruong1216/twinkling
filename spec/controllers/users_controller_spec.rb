require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    let(:user) { FactoryBot.create(:user) }
    it 'expect populates an array of user' do
      sign_in user
      get :index
      expect(assigns(:users)).to eq([user])
    end

    it 'expect renders the :index view' do
      sign_in user
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    let(:user) { FactoryBot.create(:user) }
    it 'expect assigns the requested user to @user' do
      sign_in user
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it 'expect renders the #show view' do
      sign_in user
      get :show, params: { id: user.id }
      expect(response).to render_template('show')
    end
  end
end
