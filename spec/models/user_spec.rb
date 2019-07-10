require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    user = FactoryBot.create(:user)
    expect(user).to be_valid
  end

  it 'expect user name is not nil' do
    user = FactoryBot.build(:user, user_name: nil)
    expect(user).not_to be_valid
  end

  it 'expect user full name is not nil' do
    user = FactoryBot.build(:user, full_name: nil)
    expect(user).not_to be_valid
  end

  it 'expect user email is not nil' do
    user = FactoryBot.build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it 'expect max length of user_name is 16' do
    user_name_length = FactoryBot.build(:user).user_name.length
    expect(user_name_length).to be <= 16
  end

  describe 'validates full_name' do
    context 'valid' do
      let!(:user) { FactoryBot.build(:user, full_name: 'ben') }

      it 'should be valid object' do
        expect(user).to be_valid
      end
    end

    context 'invalid' do
      let!(:user) { FactoryBot.build(:user, full_name: SecureRandom.alphanumeric(31)) }

      it 'shoud not be valid object' do
        expect(user).not_to be_valid
      end
    end
  end
end
