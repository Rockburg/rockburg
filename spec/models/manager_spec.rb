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

require 'rails_helper'

RSpec.describe Manager, type: :model do
  it "should update bands_count when adding a new band" do
    mgr = create :manager
    expect(mgr.bands.count).to eq(mgr.bands_count)

    new_band = create :band, manager: mgr
    expect(mgr.bands.count).to eq(mgr.bands_count)
  end

  it "should update bands_count when deleting a band" do
    band = create :band
    mgr = band.manager
    expect {
      band.destroy
    }.to change{mgr.bands_count}.by(-1)
  end

end
