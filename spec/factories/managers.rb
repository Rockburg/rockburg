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

FactoryBot.define do
  factory :manager do
    name      { Faker::FunnyName.name }
    email     { Faker::Internet.email }
    password  "password"
    password_confirmation "password"
  end
end
