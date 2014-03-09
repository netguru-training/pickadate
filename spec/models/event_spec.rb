require 'spec_helper'

describe 'Event' do
  let(:event) { create(:event) }

  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:user3) { create(:user) }

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