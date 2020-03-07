puts "Creating Genres"

seed_data = [
  { name: 'Dance', style: "Ambient", total_members: 1,
    skills: %w[Keyboards]
  },
  { name: 'Dance', style: "Disco", total_members: 7,
    skills: %w[Keyboards Drummer Dance Vocals Horns Percussion Backup_Vocals]
  },
  { name: 'Dance', style: "Drum & Bass", total_members: 4,
    skills: %w[Keyboards Drummer Dance Vocals]
  },
  { name: "Dance", style: "Euro Dance", total_members: 4,
    skills: %w[Keyboards Dance Vocals Backup_Vocals]
  },
  { name: "Dance", style: "Garage", total_members: 2,
    skills: %w[Keyboards Rapping]
  },
  { name: "Dance", style: "House", total_members: 2,
    skills: %w[Keyboards Vocals]
  },
  { name: "Dance", style: "Techno", total_members: 1,
    skills: %w[Keyboards]
  },
  { name: "Dance", style: "Trance", total_members: 1,
    skills: %w[Keyboards]
  },
  { name: "Folk", style: 'Bluegrass',  total_members: 4,
    skills: %w[Acoustic_Guitar Banjo Drummer Vocals]
  },
  { name: "Folk", style: "Folk Rock", total_members: 5,
    skills: %w[Acoustic_Guitar Bass_Guitar Drummer Vocals Wind]
  },
  { name: "Folk", style: "Irish Folk", total_members: 5,
    skills: %w[Acoustic_Guitar Percussion Strings Dance Wind]
  },
  { name: "Folk", style: "Traditional Folk", total_members: 3,
    skills: %w[Acoustic_Guitar Percussion Strings]
  },
  { name: "Folk", style: "World Music", total_members: 3,
    skills: %w[Percussion Vocals Wind]
  },
  { name: "Orchestral", style: "Big Band", total_members: 5,
    skills: %w[Drummer Piano Horns Dance Wind]
  },
  { name: "Orchestral", style: "Classical", total_members: 6,
    skills: %w[Acoustic_Guitar Percussion Piano Strings Dance Wind]
  },
  { name: "Orchestral", style: "Concert Pianist", total_members: 1,
    skills: %w[Piano]
  },
  { name: "Pop", style: "Brit Pop", total_members: 5,
    skills: %w[Acoustic_Guitar Electric_Guitar Bass_Guitar Drummer Vocals]
  },
  { name: "Pop", style: "Euro Pop", total_members: 4,
    skills: %w[Keyboards Bass_Guitar Dance Vocals]
  },
  { name: "Pop", style: "Boy Band", total_members: 3,
    skills: %w[Drummer Dance Vocals]
  },
  { name: "Pop", style: "Girl Band", total_members: 3,
    skills: %w[Drummer Dance Vocals]
  },
  { name: "Pop", style: "Latin", total_members: 4,
    skills: %w[Drummer Dance Vocals Percussion]
  },
  { name: "Rock", style: "Gothic", total_members: 5,
    skills: %w[Bass_Guitar Drummer Keyboards Lead_Guitar Vocals]
  },
  { name: "Rock", style: "Indie", total_members: 5,
    skills: %w[Bass_Guitar Drummer Keyboards Acoustic_Guitar Vocals]
  },
  { name: "Rock", style: "Metal", total_members: 5,
    skills: %w[Bass_Guitar Drummer Lead_Guitar Rhythm_Guitar Vocals]
  },
  { name: "Rock", style: "Punk", total_members: 4,
    skills: %w[Bass_Guitar Drummer Lead_Guitar Vocals]
  },
  { name: "Rock", style: "Rock", total_members: 4,
    skills: %w[Bass_Guitar Drummer Lead_Guitar Vocals]
  },
  { name: "Rock", style: "Ska", total_members: 5,
    skills: %w[Bass_Guitar Drummer Keyboards Horns Vocals]
  },
  { name: "Soul", style: "Blues", total_members: 5,
    skills: %w[Acoustic_Guitar Bass_Guitar Horns Vocals Wind]
  },
  { name: "Soul", style: "Funk", total_members: 9,
    skills: %w[Acoustic_Guitar Bass_Guitar Drummer Keyboards Vocals Horns Wind Percussion Backup_Vocals]
  },
  { name: "Soul", style: "Hip Hop", total_members: 3,
    skills: %w[DJ Drummer Rapping]
  },
  { name: "Soul", style: "Jazz", total_members: 6,
    skills: %w[Acoustic_Guitar Bass_Guitar Drummer Horns Wind Keyboards]
  },
  { name: "Soul", style: "Rap", total_members: 2,
    skills: %w[DJ Rapping]
  },
  { name: "Soul", style: "Reggae", total_members: 4,
    skills: %w[Acoustic_Guitar Drummer Dance Rapping]
  },
  { name: "Soul", style: "Raggae", total_members: 3,
    skills: %w[Keyboards DJ Vocals]
  },
  { name: "Vocalist", style: "Solo", total_members: 1,
    skills: %w[Vocals]
  }
]

seed_data.each do |seed|
  skills = seed.delete(:skills).map{|e| e.gsub('_',' ')}
  genre = Genre.where(name: seed[:name], style: seed[:style]).first_or_initialize
  genre.update(seed)

  # Add or remove skills found in the DB
  skills_found = genre.skills.pluck(:name)
  skills_removed = skills_found - skills
  skills_added = skills - skills_found

  skills_added.each do |skill|
    skill = Skill.where(name: skill).first_or_create
    genre.skills << skill
  end
  to_be_removed = Skill.where(name: skills_removed).to_a
  genre.skills.delete(to_be_removed)

  puts "  #{genre.name} / #{genre.style}".blue
end
puts

puts "Skills Found"
Skill.order(:name).each do |skill|
  puts "  #{skill.name}".blue
end
puts
