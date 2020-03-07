return if Genre.count > 0

# In the Test environment, we need a few Genres present
puts "Creating Genres"

seed_data = [
  { name: 'Dance', style: "Disco", min_members: 4, max_members: 6,
    skills: %w[Keyboards Drummer Dance Vocals Horns Percussion Backup_Vocals]
  },
  { name: 'Dance', style: "Drum & Bass", min_members: 1, max_members: 3,
    skills: %w[Keyboards Drummer Dance Vocals]
  },
  { name: "Folk", style: 'Bluegrass',  min_members: 4, max_members: 5,
    skills: %w[Acoustic_Guitar Banjo Drummer Vocals]
  },
  { name: "Folk", style: "Folk Rock", min_members: 5, max_members: 6,
    skills: %w[Acoustic_Guitar Bass_Guitar Drummer Vocals Wind]
  },
  { name: "Orchestral", style: "Big Band", min_members: 5, max_members: 6,
    skills: %w[Drummer Piano Horns Dance Wind]
  },
  { name: "Orchestral", style: "Classical", min_members: 6, max_members: 7,
    skills: %w[Acoustic_Guitar Percussion Piano Strings Dance Wind]
  },
  { name: "Pop", style: "Brit Pop", min_members: 3, max_members: 5,
    skills: %w[Acoustic_Guitar Electric_Guitar Bass_Guitar Drummer Vocals]
  },
  { name: "Pop", style: "Euro Pop", min_members: 3, max_members: 5,
    skills: %w[Keyboards Bass_Guitar Dance Vocals]
  },
  { name: "Rock", style: "Gothic", min_members: 4, max_members: 6,
    skills: %w[Bass_Guitar Drummer Keyboards Lead_Guitar Vocals]
  },
  { name: "Rock", style: "Indie", min_members: 4, max_members: 6,
    skills: %w[Bass_Guitar Drummer Keyboards Acoustic_Guitar Vocals]
  },
  { name: "Soul", style: "Blues", min_members: 4, max_members: 6,
    skills: %w[Acoustic_Guitar Bass_Guitar Horns Vocals Wind]
  },
  { name: "Soul", style: "Funk", min_members: 5, max_members: 7,
    skills: %w[Acoustic_Guitar Bass_Guitar Drummer Keyboards Vocals Horns Wind Percussion Backup_Vocals]
  },
  { name: "Vocalist", style: "Solo", min_members: 1, max_members: 1,
    skills: %w[Vocals]
  }
]

seed_data.each do |seed|
  skills = seed.delete(:skills)
  genre = Genre.where(name: seed[:name], style: seed[:style]).first_or_initialize
  genre.update(seed)

  skills.each do |skill|
    skill = Skill.where(name: skill).first_or_create
    genre.skills << skill unless genre.skills.where(name: skill).exists?
  end
  puts "  #{genre.name} / #{genre.style}".blue
end
puts
