class DurationDecorator < Draper::Decorator
  delegate_all

  def get_hour_from_index index
     ( self.start_date + ( index * Event::TIME_UNIT ).hour ).strftime("%H:%M")
  end

end