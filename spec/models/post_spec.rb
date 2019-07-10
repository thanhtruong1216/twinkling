require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'has a valid factory' do
    post = create(:post)
    expect(post).to be_valid
  end

  describe 'validate post content' do
    let(:user) { create(:user) }

    context 'with a valid content' do
      it 'content is presence' do
        post = create(:post, content: 'My post', user: user)
        expect(post).to be_valid
      end
      it 'length of post is less than or equal 200' do
        post = create(:post, content: SecureRandom.alphanumeric(199), user: user)
        expect(post).to be_valid
      end
    end

    context 'with a invalid content' do
      it 'content is nil' do
        post = build(:post, content: nil, user: user)
        expect(post).not_to be_valid
      end
      it 'length of post is greater than 200' do
        post = build(:post, content: SecureRandom.alphanumeric(201), user: user)
        expect(post).not_to be_valid
      end
    end

  end

  describe 'upload post photo' do
    let(:user) { create(:user) }
    context 'with a valid avatar' do
      it 'photo is attached' do
        post = build(:post, photo: 'photo.png', user: user)
        expect(post).to be_valid
      end
    end

    context 'with a invalid avatar' do
      it 'photo is nil' do
        post = build(:post, photo: nil, user: user)
        expect(post).not_to be_valid
      end
    end
  end

end
