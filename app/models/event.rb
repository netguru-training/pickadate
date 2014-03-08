class Event
  include Mongoid::Document

  has_many :users_events
  embeds_one :duration
end
