class Event
  include Mongoid::Document

  TIME_UNIT = 0.5
  has_many :users_events
  has_one  :creator , class_name: 'User', inverse_of: :event
  has_and_belongs_to_many :guests, class_name: 'User', inverse_of: nil
  embeds_one :duration

  validates :name, presence: true, length: { minimum: 5 }

  accepts_nested_attributes_for :duration

  field :name, type: String
  field :invite_only, type: Boolean, default: false

  def match_friends_for_user(user)
    event_for_user = users_events.find_by(user_id: user.id)
    results = {}

    (users_events - [event_for_user]).each do |users_event|
      common_events = event_for_user.availability.zip(users_event.availability).map { |e| e.reduce("&") }
      results[users_event.user.id.to_s] = common_events
    end

    return results
  end

  def is_created_by? user
    creator == user
  end

  def is_visible_for_user? user
    !self.invite_only || self.is_created_by?(user) || self.guests.include?(user)
  end

  def time_fields
    ( ( ( duration.end_date - duration.start_date ) * 24 ) / TIME_UNIT ).round
  end
end
