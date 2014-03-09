require "spec_helper"

describe Event do

  it { should validate_presence_of(:name) }

  it { should ensure_length_of(:name).is_at_least(5) }

  describe "is_created_by?" do
    let!(:event) {create(:event)}
    let!(:user) {create(:user)}
    let!(:user2) {create(:user)}


    it 'should return true for creator' do 
      expect(event.is_created_by?(event.creator)).to be_true
    end

    it 'should return false for non creator' do 
      expect(event.is_created_by?(user)).to be_false
    end

  end

end