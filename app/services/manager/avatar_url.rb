class Manager::AvatarURL < ApplicationService
  expects do
    required(:manager).filled
  end

  delegate :manager, :seed, to: :context

  before do
    context.manager = Manager.ensure!(manager)
    context.seed = "#{manager.id}#{manager.name}#{manager.name.length}".to_i
  end

  ATTRIBUTES = {
    topType: %w[NoHair Eyepatch Hat Hijab Turban LongHairBigHair LongHairBob LongHairBun LongHairCurly LongHairCurvy LongHairDreads LongHairFrida LongHairFro LongHairFroBand LongHairNotTooLong LongHairShavedSides LongHairMiaWallace LongHairStraight LongHairStraight2 LongHairStraightStrand ShortHairDreads01 ShortHairDreads02 ShortHairFrizzle ShortHairShaggyMullet ShortHairShortCurly ShortHairShortFlat ShortHairShortRound ShortHairShortWaved ShortHairSides ShortHairTheCaesar ShortHairTheCaesarSidePart WinterHat1 WinterHat2 WinterHat3 WinterHat4],
    accessoriesType: %w[Blank Blank Blank Blank Blank Blank Blank Blank Blank Kurt Prescription01 Prescription02 Round Sunglasses Wayfarers],
    hairColor: %w[Auburn Black Blonde BlondeGolden Brown BrownDark PastelPink Platinum Red SilverGray],
    hatColor: %w[Black Blue01 Blue02 Blue03 Gray01 Gray02 Heather PastelBlue PastelGreen PastelOrange PastelRed PastelYellow Pink Red White],
    facialHairType: %w[Blank BeardMedium BeardLight BeardMagestic MoustacheFancy MoustacheMagnum],
    facialHairColor: %w[Auburn Black Blonde BlondeGolden Brown BrownDark Platinum Red],
    clotheType: %w[BlazerShirt BlazerSweater CollarSweater GraphicShirt Hoodie Overall ShirtCrewNeck ShirtScoopNeck ShirtVNeck],
    clotheColor: %w[Black Blue01 Blue02 Blue03 Gray01 Gray02 Heather PastelBlue PastelGreen PastelOrange PastelRed PastelYellow Pink Red White],
    graphicType: %w[Bat Cumbia Deer Diamond Hola Pizza Resist Selena Bear SkullOutline Skull],
    eyeType: %w[Close Cry Default Dizzy EyeRoll Happy Side Squint Surprised Wink WinkWacky],
    eyebrowType: %w[Angry AngryNatural Default DefaultNatural FlatNatural RaisedExcited RaisedExcitedNatural SadConcerned SadConcernedNatural UnibrowNatural UpDown UpDownNatural],
    mouthType: %w[Concerned Default Disbelief Eating Grimace Sad ScreamOpen Serious Smile Tongue Twinkle],
    skinColor: %w[Tanned Yellow Pale Light Brown DarkBrown Black],
  }.freeze

  def call
    chosen_attributes = ATTRIBUTES.map.with_index do |(k, v), index|
      [k, v.sample(random: Random.new(seed + index + 1))]
    end.to_h

    context.result = "https://rockburg-avataaars.onrender.com/?#{chosen_attributes.to_param}"
  end
end
