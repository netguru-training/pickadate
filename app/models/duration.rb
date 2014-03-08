class Duration
  include Mongoid::Document

  embedded_in :event

  field :name, type: String
  field :start_date, type: DateTime
  field :end_date, type: DateTime
  
end
