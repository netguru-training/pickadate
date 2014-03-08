require 'spec_helper'

describe 'Event' do
  let(:event) { Event.create!(name: 'test event', duration: {start_date: DateTime.new(2014, 3, 7, 9, 0, 0), end_date: DateTime.new(2014, 3, 7, 11, 0, 0)}) }

  let(:user1) { User.create!(email: 'foo1@bar.com', password: '12345678', password_confirmation: '12345678') }
  let(:user2) { User.create!(email: 'foo2@bar.com', password: '12345678', password_confirmation: '12345678') }
  let(:user3) { User.create!(email: 'foo3@bar.com', password: '12345678', password_confirmation: '12345678') }

  before do
    UsersEvent.create!(availability: [1,1], event: event, user: user1)
    UsersEvent.create!(availability: [0,1], event: event, user: user2)
    UsersEvent.create!(availability: [0,0], event: event, user: user3)
  end

  describe '#match_friends' do
    it 'returns matched time availability' do
      event.match_friends_for_user(user1).should eq(user2.id.to_s => [0,1], user3.id.to_s => [0,0])
    end
  end
end