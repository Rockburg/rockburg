# == Schema Information
#
# Table name: external_sentiments
#
#  id         :bigint(8)        not null, primary key
#  content    :jsonb
#  source     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ExternalSentiment < ActiveRecord::Base
  serialize :content, Hash

  def self.most_recent_from(source)
    self.where(source: source).last.try(:content)
  end
end
