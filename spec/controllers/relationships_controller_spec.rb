require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do
  describe 'follow' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    it 'allow an user can follow another user' do
      sign_in user1
      post :create, params: { followed_id: user2.id, format: :js }
      expect(response.content_type).to eq('text/javascript')
      expect(response).to render_template('create')
    end

  end

  describe 'unfollow' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:relationship) { Relationship.create(follower: user1, followed: user2) }
    it 'expect unfollow a user' do
      sign_in user1
      delete :destroy, params: { id: relationship.id, format: :js }
      expect(response.content_type).to eq('text/javascript')
      expect(response).to render_template('destroy')
      expect(Relationship.exists?(follower: user1, followed: user2)).to be_falsy
    end
  end
end
