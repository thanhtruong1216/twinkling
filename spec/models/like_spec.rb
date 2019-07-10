require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'has a valid factory' do
    like = create(:like)
    expect(like).to be_valid
  end

  describe 'validate user' do
    let(:user) { create(:user) }
    context 'valid' do
      it 'user is nil' do
        like_user = build(:like, user: nil)
        expect(like_user).not_to be_valid
      end
    end

    context 'invalid' do
      it 'user is presence' do
        like_user = build(:like, user: user)
        expect(like_user).to be_valid
      end
    end
  end

  describe 'validate post' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }
    context 'valid' do
      it 'post is presence' do
        like_post= build(:like, post: post)
        expect(like_post).to be_valid
      end
    end

    context 'invalid' do
      it 'post is nil' do
        like_post= build(:like, post: nil)
        expect(like_post).not_to be_valid
      end
    end
  end
end
