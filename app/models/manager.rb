# == Schema Information
#
# Table name: managers
#
#  id                     :bigint(8)        not null, primary key
#  balance                :bigint(8)        default(0)
#  bands_count            :integer          default(0)
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  last_seen_at           :datetime
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  level                  :integer          default(0)
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  sash_id                :integer
#
# Indexes
#
#  index_managers_on_balance               (balance)
#  index_managers_on_email                 (email) UNIQUE
#  index_managers_on_reset_password_token  (reset_password_token) UNIQUE
#

class Manager < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## -- SCOPES
  scope :with_bands, -> { where('bands_count > 0') }

  ## -- RELATIONSHIPS
  has_many :bands, counter_cache: :bands_count
  has_many :financials
  has_many :members, through: :bands
  has_many :member_bands, through: :bands
  has_many :recordings, through: :bands

  ## -- VALIDATIONS
  validates :name, uniqueness: true

  ## -- CALLBACKS
  after_create :give_starting_balance
  after_create :give_badge

  ## — INSTANCE METHODS
  def to_param
    [id, name.parameterize].join("-")
  end

  def give_starting_balance
    self.financials.create!(amount: 500) if !self.financials.exists?
    self.update_balance
  end

  def give_badge
    self.add_badge(1)
  end

  def update_balance
    self.balance = self.financials.sum(:amount)
  end

  def update_balance!
    was_low_balance = self.low_balance?
    was_negative = self.negative?

    cur_balance = self.update_balance
    self.update_columns(balance: cur_balance)

    if !was_negative && self.negative?
      ManagerMailer.with(user: self).balance_negative.deliver_later
    elsif !was_low_balance && self.low_balance?
      ManagerMailer.with(user: self).balance_getting_low.deliver_later
    end
  end

  def avatar_url
    Manager::AvatarURL.(manager: self).result
  end

  def file_bankruptcy
    self.bands.each do |band|
      band.recordings.destroy_all
    end
    self.bands.delete_all
    self.financials.destroy_all
    self.give_starting_balance
    Manager.reset_counters(self.id, :bands)
  end

  def bankrupt?
    self.balance <= -1000
  end

  def low_balance?
    self.balance < 250 and self.balance > 0
  end

  def negative?
    self.balance > -1000 and self.balance < 0
  end
end
