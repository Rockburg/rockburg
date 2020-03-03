module Generator

  def self.band_name
    Faker::Hipster.sentence(word_count: 2, supplemental: false, random_words_to_add: 0).delete('.').titleize
  end

  def self.album_name
    Faker::Hipster.sentence(word_count: 2, supplemental: false, random_words_to_add: 0).delete('.').titleize
  end

  def self.song_title
    Faker::Hipster.sentence(word_count: 2, supplemental: false, random_words_to_add: 0).delete('.').titleize
  end

end