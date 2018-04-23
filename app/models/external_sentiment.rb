class ExternalSentiment < ActiveRecord::Base
  serialize :content, Hash

  def self.most_recent_from(source)
    self.where(source: source).last.try(:content)
  end
end
