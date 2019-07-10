require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'has a valid factory' do
    like = create(:like)
    expect(like).to be_valid
  end

  it 'expect a like must belongs to a user' do
    like_user = build(:like, user: nil)
    expect(like_user).not_to be_valid
  end

  it 'expect a like mus belongs to a post' do
    like_post = build(:like, post: nil)
    expect(like_post).not_to be_valid
  end
end
