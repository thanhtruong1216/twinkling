require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'has a valid factory' do
    post = create(:post)
    expect(post).to be_valid
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'post content length' do
    let(:user) { create(:user) }
    context 'with a valid content' do
      let(:post) { build(:post, content: SecureRandom.alphanumeric(199), user: user) }
      it 'length of post is less than or equal 200' do
        expect(post).to be_valid
      end
    end

    context 'with a invalid content' do
      let(:post) { build(:post, content: SecureRandom.alphanumeric(201), user: user) }
      it 'length of post is greater than 200' do
        expect(post).not_to be_valid
      end
    end

  end

  describe 'upload post photo' do
    let(:user) { create(:user) }
    context 'with a valid avatar' do
      let(:post) { build(:post, photo: 'photo.png', user: user) }
      it 'photo is attached' do
        expect(post).to be_valid
      end
    end
  end

end
