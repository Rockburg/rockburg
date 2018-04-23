namespace :external_sentiments do
  desc 'collect data from real world music services to influence game drivers'
  task :daily => :environment do
    sentiment = Lastfm.sentiment
    ExternalSentiment.create(source: 'lastfm', content: sentiment)

    # insert more
  end
end
