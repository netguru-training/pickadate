class Event
  include Mongoid::Document

  has_many :users_events
end
