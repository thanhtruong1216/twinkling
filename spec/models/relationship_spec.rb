require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'validate follower' do
    context 'associations' do
      it { should belong_to(:follower).class_name('User') }
      it { should belong_to(:followed).class_name('User') }
    end
  end

end
