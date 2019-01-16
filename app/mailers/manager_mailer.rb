class ManagerMailer < ApplicationMailer
  include ApplicationHelper
  add_template_helper(ApplicationHelper)

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.manager_mailer.balance_getting_low.subject
  #
  def balance_getting_low
    @user = params[:user]
    @balance = as_game_currency(@user.balance)

    mail to: @user.email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.manager_mailer.balance_negative.subject
  #
  def balance_negative
    @user = params[:user]
    @balance = as_game_currency(-1000)

    mail to: @user.email
  end
end
