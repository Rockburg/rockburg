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

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.manager_mailer.activity_completed.subject
  #
  def activity_completed
    @user = params[:user]
    @band = params[:band]
    @activity = params[:activity]

    action = @activity.action.sub('_', ' ')
    action = case action
    when 'practice'          then 'has finished practicing'
    when 'gig'               then 'has finished playing a gig'
    when 'hired'             then 'has hired a new member'
    when 'release'           then 'has finished their release'
    when 'write song'        then 'has written a song'
    when 'record single'     then 'has recorded as single'
    when 'formed'            then 'has formed'
    when 'fired'             then 'has fired a member'
    when 'rest'              then 'has rested'
    when 'recording deleted' then 'has deleted a recording'
    else action
    end

    mail to: @user.email, subject: default_i18n_subject(band_name: @band.name, action: action)
  end
end
