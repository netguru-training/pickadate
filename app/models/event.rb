class Event
  include Mongoid::Document

  has_many :users_events
  embeds_one :duration

  accepts_nested_attributes_for :duration

  field :name, type: String

end
