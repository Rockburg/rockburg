puts 'Creating External Sentiments'

seed_data = [
  { source: 'lastfm',
    content: {'Rock'=>7284, 'Pop'=>3603, 'Vocalist'=>1102, 'Dance'=>786, 'Soul'=>474, 'Folk'=>290}
  }
  # add more sources, ie Spotify etc
]

seed_data.each do |seed|
  sentiment = ExternalSentiment.create(seed)
  puts "  #{sentiment.source} / #{sentiment.content}".blue
end
puts
