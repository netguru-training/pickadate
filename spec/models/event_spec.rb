require 'spec_helper'

describe 'Event' do
  let(:event) { create(:event) }

  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:user3) { create(:user) }
  # let(:user1) { User.create!(email: 'foo1@bar.com', password: '12345678', password_confirmation: '12345678') }
  # let(:user2) { User.create!(email: 'foo2@bar.com', password: '12345678', password_confirmation: '12345678') }
  # let(:user3) { User.create!(email: 'foo3@bar.com', password: '12345678', password_confirmation: '12345678') }

  before do
    create(:users_event, availability: [1,1], event: event, user: user1)
    create(:users_event, availability: [0,1], event: event, user: user2)
    create(:users_event, event: event, user: user3)
  end

  describe '#match_friends' do
    it 'returns matched time availability' do
      event.match_friends_for_user(user1).should eq(user2.id.to_s => [0,1], user3.id.to_s => [0,0])
    end
  end
end