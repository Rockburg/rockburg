class Band::ReleaseRecording < ApplicationService
  include ActionView::Helpers::NumberHelper
  include ApplicationHelper

  expects do
    required(:band).filled
    required(:activity).filled.value(type?: Integer)
    required(:release).filled
  end

  delegate :band, :release, :activity, to: :context

  before do
    context.band = Band.ensure!(band)
    context.release = band.releases.ensure!(release)
  end

  def call
    release.transaction do
      band.happenings.create(what: "You've released #{release.name} (#{release.kind}) and will start earning money from streams within a day!", kind: 'release_earned', activity_id: activity)
    end
  end
end
