require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'has a valid factory' do
    comment = build(:comment)
    expect(comment).to be_valid
  end

  it 'expect comment content must be not nil' do
    comment_content = build(:comment, content: nil)
    expect(comment_content).not_to be_valid
  end

  it 'expect a comment must belongs to a user' do
    comment = build(:comment, user: nil)
    expect(comment).not_to be_valid
  end

  it 'expect a comment must belongs to a post' do
    comment = build(:comment, post: nil)
    expect(comment).not_to be_valid
  end

end
