class UsersEventDecorator < Draper::Decorator
  delegate_all

  def cell_from_availability avaliability
    avaliability.zero? ? 'remove' : 'ok'
  end
end