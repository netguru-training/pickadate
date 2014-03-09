class EventDecorator < Draper::Decorator
  delegate_all

  def start_date
    parse_date(self.duration.start_date)
  end

  def end_date
    parse_date(self.duration.end_date)
  end

  def is_visible_for_user? user
    !self.invite_only || self.is_created_by?(user) || self.guests.include?(user)
  end

  private

  def parse_date date
    date.strftime("%H:%M (%d-%m-%y)")
  end

end
