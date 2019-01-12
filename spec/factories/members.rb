# == Schema Information
#
# Table name: members
#
#  id                    :bigint(8)        not null, primary key
#  birthdate             :date
#  cost                  :integer          default(0), not null
#  gender                :string           default("")
#  name                  :string           default("")
#  skill_primary         :integer
#  skill_primary_level   :integer          default(0)
#  skill_secondary       :integer
#  skill_secondary_level :integer          default(0)
#  skill_tertiary        :integer
#  skill_tertiary_level  :integer          default(0)
#  trait_aptitude        :integer          default(0), not null
#  trait_creativity      :integer          default(0), not null
#  trait_drive           :integer          default(0), not null
#  trait_ego             :integer          default(0), not null
#  trait_fatigue         :integer          default(0), not null
#  trait_looks           :integer          default(0), not null
#  trait_network         :integer          default(0), not null
#  trait_productivity    :integer          default(0), not null
#  trait_stamina         :integer          default(0), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

FactoryBot.define do
  factory :member do
    name      { Faker::FunnyName.name }
    gender    { %w[male female].sample }
    birthdate { Faker::Date.birthday(18, 40) }
    trait_ego         { rand(0..100) }
    trait_looks       { rand(0..100) }
    trait_creativity  { Sample.weighted(1..100) }
    trait_fatigue 0
    primary_skill { Skill.all.sample }
    skill_primary_level { Sample.weighted(1..100) }
  end
end
