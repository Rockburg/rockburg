module Lastfm

  BASE_URL = 'http://ws.audioscrobbler.com'
  VERSION = '/2.0/'

  class << self
    def sentiment(result = {})
      external_genres = popular_genres
      local_genres = Genre.all.map(&:name).uniq

      external_genres.each do |external|
        local_genres.each do |local|
          next unless external[0].include?(local.downcase) # genre mapping
          result[local] ? result[local] += external[1] : result[local] = external[1]
        end
      end

      # {"Rock"=>7284, "Pop"=>3603, "Vocalist"=>1102, "Dance"=>786, "Soul"=>474, "Folk"=>290}
      result
    end

    def top_artists_url
      BASE_URL + VERSION + "?method=chart.gettopartists&api_key=#{ENV['LASTFM_API_KEY']}&format=json&limit=100"
    end

    def top_tags_url(artist_mbid)
      BASE_URL + VERSION + "?method=artist.gettoptags&mbid=#{artist_mbid}&api_key=#{ENV['LASTFM_API_KEY']}&format=json"
    end

    def top_artists
      resp = HTTParty.get(top_artists_url)
      resp.success? ? JSON.parse(resp.body)['artists']['artist'] : []
    end

    def top_tags(artist_mbid)
      resp = HTTParty.get(top_tags_url(artist_mbid))
      resp.success? ? JSON.parse(resp.body)['toptags']['tag'] : []
    end

    def popular_genres(result = {})
      artists = top_artists

      artists.each do |artist|
        next if artist['mbid'].blank? # not all artists have music brain ID
        tags = top_tags(artist['mbid'])

        tags[0..4].each do |tag|
          result[tag['name']] ? result[tag['name']] += tag['count'] : result[tag['name']] = tag['count']
        end
      end

      # {"rock"=>2780, "pop"=>1810, "indie"=>1696, "rnb"=>1412}
      result.sort_by { |_,v| v }.reverse.to_h
    end
  end

end
