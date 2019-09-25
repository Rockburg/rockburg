after :genres do
  if Member.count < 500
    puts "Creating 500 Members"
    skills = Skill.all.to_a
    500.times {
      m = Member.create!(
        name: Faker::FunnyName.name,
        birthdate: Faker::Date.birthday(min_age: 15, max_age: 75),
        trait_ego: rand(0..100),
        trait_looks: rand(0..100),
        trait_creativity: Sample.weighted(1..100),
        trait_fatigue: 0,
        primary_skill: skills.sample,
        skill_primary_level: Sample.weighted(1..100)
      )
      puts "  #{m.name} / #{m.primary_skill.name}(#{m.skill_primary_level})".blue
    }
    puts
  end
end