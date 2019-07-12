require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'POST #create' do
    def do_request
      post :create, params: { post_id: target_post.id, comment: { content: comment.content }, format: :js }
    end

    let(:user) { create(:user) }
    let(:target_post) { create(:post) }
    let(:comment) { create(:comment, user: user, post: target_post) }

    before do
      sign_in user
    end

    it 'should return a new comment' do
      comment.should be_an_instance_of Comment
    end

    it 'response correct layout and format' do
      do_request
      expect(response.content_type).to eq('text/javascript')
      expect(response).to render_template('create')
    end

  end

  describe 'PUT #update' do
    def do_request
      put :update, params: { post_id: target_post.id, id: comment.id, comment: { content: 'new comment' }, format: :js }
    end

    let(:user) { create(:user) }
    let(:target_post) { create(:post, user: user) }
    let(:comment) { create(:comment, user: user, post: target_post) }
    before do
      ActionController::Base.allow_forgery_protection = false
      sign_in user
    end

    after do
      ActionController::Base.allow_forgery_protection = true
    end

    it 'response correct layout and format' do
      do_request
      expect(response.content_type).to eq('text/javascript')
      expect(response).to render_template('update')
    end

  end

  describe 'DELETE #destroy' do
    def do_request
      delete :destroy, params: { post_id: target_post.id, id: target_comment.id, format: :js }
    end

    let(:user) { create(:user) }
    let(:target_post) { create(:post, user: user) }
    let(:target_comment) { create(:comment, user: user, post: target_post) }

    before do
      sign_in user
    end

    it 'expect remove comment from table comments' do
      expect(Comment.count).to be == 0
    end

    it 'response correct layout and format' do
      do_request
      expect(response.content_type).to eq('text/javascript')
      expect(response).to render_template('destroy')
    end
  end

end
