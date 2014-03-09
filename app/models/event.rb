class Event
  include Mongoid::Document

  TIME_UNIT = 0.5
  has_many :users_events
  has_one  :creator , class_name: 'User', inverse_of: :event
  has_and_belongs_to_many :guests, class_name: 'User', inverse_of: nil
  embeds_one :duration
  before_create :generate_token

  validates :name, presence: true, length: { minimum: 5 }

  accepts_nested_attributes_for :duration

  field :name, type: String
  field :invite_only, type: Boolean, default: false
  field :token, type: String

  def is_created_by? user
    creator == user
  end

  def is_visible_for_user? user
    user.present? ? !self.invite_only || self.is_created_by?(user) || self.guests.include?(user) : false
  end

  def time_fields
    ( ( ( duration.end_date - duration.start_date ) * 24 ) / TIME_UNIT ).round
  end

  def has_user? user
    users_events.in(user_id: user.id).present? if user
  end

  private

  def generate_token
    tokens = Event.all.map(&:token)
    begin
      self.token = SecureRandom.hex
    end while tokens.include?(self.token)
  end

end
