class Event
  include Mongoid::Document

  has_many :users_events
  has_one  :creator , class_name: 'User', inverse_of: nil
  embeds_one :duration

  accepts_nested_attributes_for :duration

  field :name, type: String

end
