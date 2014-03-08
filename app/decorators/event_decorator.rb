class EventDecorator < Draper::Decorator
  delegate_all

  def start_date
    parse_date(self.duration.start_date)
  end

  def end_date
    parse_date(self.duration.end_date)
  end

  private

  def parse_date date
    date.strftime("%H:%M (%d-%m-%y)")
  end

end
