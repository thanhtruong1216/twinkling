require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'has a valid factory' do
    like = create(:like)
    expect(like).to be_valid
  end

  describe 'associations' do
    it { should belong_to(:post) }
  end


  describe 'associations' do
    it { should belong_to(:user) }
  end

end
