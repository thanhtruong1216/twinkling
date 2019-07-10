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
      it 'expect content is presence' do
        comment = build(:comment, content: 'My comment', user: user, post: post)
        expect(comment).to be_valid
      end
      it 'expect content is less than or equal to 200' do
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

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'associations' do
    it { should belong_to(:post) }
  end


end
