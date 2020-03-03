module ApplicationHelper
  def as_game_currency(number)
    ActiveSupport::NumberHelper.number_to_currency(number, precision: 0, unit: '<span class="currency">§</span>').html_safe
  end
end
