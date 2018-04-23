require 'rails_helper'

RSpec.describe Lastfm do

  let(:sample_popular_genres) do
    {"rock"=>2780, "pop"=>1810, "indie"=>1696, "electronic"=>1412, "alternative"=>1296, "Hip-Hop"=>1025, "classic rock"=>892, "female vocalists"=>887, "indie rock"=>726, "alternative rock"=>725, "rnb"=>666, "rap"=>652, "british"=>546, "dance"=>533, "House"=>479, "seen live"=>432, "soul"=>382, "indie pop"=>324, "britpop"=>281, "pop punk"=>271, "punk rock"=>271, "hard rock"=>263, "Grunge"=>248, "80s"=>246, "punk"=>241, "folk"=>237, "singer-songwriter"=>227, "metal"=>191, "new wave"=>187, "post-punk"=>185, "emo"=>183, "Psychedelic Rock"=>172, "psychedelic"=>160, "chillout"=>144, "pop rock"=>136, "dream pop"=>100, "country"=>100, "experimental"=>100, "acoustic"=>100, "Progressive rock"=>100, "thrash metal"=>100, "Stoner Rock"=>100, "glam rock"=>99, "Disney"=>97, "alternative metal"=>94, "electro house"=>92, "Nu Metal"=>92, "dancehall"=>89, "heavy metal"=>74, "Canadian"=>73, "trap"=>69, "electro"=>53, "70s"=>48, "male vocalists"=>47, "ofwgkta"=>46, "dubstep"=>42, "hip hop"=>40, "irish"=>38, "Eminem"=>33}
  end

  let(:sample_ranked_local_genres) do
    {"Rock"=>5992, "Pop"=>2922, "Vocalist"=>934, "Dance"=>622, "Soul"=>382, "Folk"=>237}
  end

  before do
    allow(Lastfm).to receive(:popular_genres).and_return(sample_popular_genres)
  end

  describe '#sentiment' do
    it 'should rank local genres according to real world sentiment' do
      expect(Lastfm.sentiment).to eq sample_ranked_local_genres
    end
  end

end
