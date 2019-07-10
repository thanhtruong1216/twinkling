require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    user = create(:user)
    expect(user).to be_valid
  end

  describe 'validate user name' do
    context 'valid' do
      it 'user name is presence' do
        user = build(:user, user_name: 'Thanh Thanh')
      end
      it 'max length is less than or equal to 16' do
        user= build(:user, user_name: SecureRandom.alphanumeric(15))
        expect(user).to be_valid
      end
    end

    context 'invalid' do
      it 'user name is nil' do
        user = build(:user, user_name: nil)
        expect(user).not_to be_valid
      end
      it ' max length greater than 16' do
        user= build(:user, user_name: SecureRandom.alphanumeric(17))
        expect(user).not_to be_valid
      end
    end
  end

  describe 'user email' do
    context 'valid' do
      let(:user) { build(:user, email: 'thanhthanh@gmail.com') }
      it 'email is presence' do
        expect(user).to be_valid
      end
    end

    context 'invalid' do
      let(:user) { build(:user, email: nil) }
      it 'email is nil' do
        expect(user).not_to be_valid
      end
    end

  end

  describe 'validate user full_name' do
    context 'valid' do
      let(:user) { build(:user, full_name: 'ben') }
      it 'full name is valid' do
        expect(user).to be_valid
      end
    end

    context 'invalid' do
      it 'full name is nil' do
        user = build(:user, full_name: nil)
        expect(user).not_to be_valid
      end
      it 'full name is greater than 30' do
        user = build(:user, full_name: SecureRandom.alphanumeric(31))
        expect(user).not_to be_valid
      end
    end

  end

end
