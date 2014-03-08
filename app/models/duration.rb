class Duration
  include Mongoid::Document

  embedded_in :event

  validates :start_date, :end_date, presence: true

  field :start_date, type: DateTime
  field :end_date, type: DateTime

end
