require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'has a valid factory' do
    comment = build(:comment)
    expect(comment).to be_valid
  end

  describe 'validates content' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }
    context 'valid' do
      it 'content is presence' do
        comment = build(:comment, content: 'My comment', user: user, post: post)
        expect(comment).to be_valid
      end
      it 'content is less than or equal to 200' do
        comment = build(:comment, content: SecureRandom.alphanumeric(199), user: user, post: post)
        expect(comment).to be_valid
      end
    end

    context 'invalid' do
      it 'content is nil' do
        comment = build(:comment, content: nil)
        expect(comment).not_to be_valid
      end
      it 'content is greater than 200' do
        comment = build(:comment, content: SecureRandom.alphanumeric(201), user: user, post: post)
        expect(comment).not_to be_valid
      end
    end
  end

  describe 'validate user' do
    let(:user) { create(:user) }
    context 'valid' do
      it 'user is presence' do
        comment = build(:comment, user: user)
        expect(comment).to be_valid
      end
    end

    context 'invalid' do
      it 'user is nil' do
        comment = build(:comment, user: nil)
        expect(comment).not_to be_valid
      end
    end
  end

  describe 'validate post' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }
    context 'valid' do
      let(:comment) { create(:comment, post: post, user: user) }
      it 'post is presence' do
        expect(comment).to be_valid
      end
    end

    context 'invalid' do
      let(:comment) { build(:comment, post: nil)}
      it 'post is nil' do
        expect(comment).not_to be_valid
      end
    end
  end

end
