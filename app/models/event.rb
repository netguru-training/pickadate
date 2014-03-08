class Event
  include Mongoid::Document

  TIME_UNIT = 0.5
  has_many :users_events
  has_one  :creator , class_name: 'User', inverse_of: nil
  embeds_one :duration

  validates :name, presence: true, length: { minimum: 5 }

  accepts_nested_attributes_for :duration

  field :name, type: String

  def match_friends_for_user(user)
    event_for_user = users_events.find_by(user_id: user.id)
    results = {}

    (users_events - [event_for_user]).each do |users_event|
      common_events = event_for_user.availability.zip(users_event.availability).map { |e| e.reduce("&") }
      results[users_event.user.id.to_s] = common_events
    end

    return results
  end

  def time_fields
    ( ( ( duration.end_date - duration.start_date ) * 24 ) / TIME_UNIT ).round
  end
end
