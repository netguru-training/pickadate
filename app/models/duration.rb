class Duration
  include Mongoid::Document

  embedded_in :event

  validates :start_date, :end_date, presence: true
  validate :validate_time_format

  field :start_date, type: DateTime
  field :end_date, type: DateTime

  def validate_time_format
    errors.add(:end_date, "Please add date after start time") if end_date <= start_date
  end

end
