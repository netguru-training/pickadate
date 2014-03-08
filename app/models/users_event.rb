class UsersEvent
  include Mongoid::Document

  belongs_to :event
  belongs_to :user

  field :availability, type: Array, default: []
end
