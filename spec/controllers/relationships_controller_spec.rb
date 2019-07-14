require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do
  describe 'follow' do
    let(:user) { create(:user) }
    it 'allow an user can follow another user' do
      sign_in user
      post :create, params: { id: user.id, format: :js }
      expect(response.content_type).to eq('text/javascript')
      expect(response).to render_template('create')
    end

    it 'expect unfollow a user' do
      sign_in user
      delete :destroy, params: { id: user.id, format: :js }
      expect(response.content_type).to eq('text/javascript')
      expect(response).to render_template('destroy')
    end
  end
end
