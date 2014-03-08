class Duration
  include Mongoid::Document

  embedded_in :event

  field :start_date, type: DateTime
  field :end_date, type: DateTime

end
