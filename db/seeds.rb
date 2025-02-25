# Clear existing data
Exercise.destroy_all
Muscle.destroy_all
MuscleGroup.destroy_all

# Define Muscle Groups
muscle_groups = {
  "Chest" => ["Pectoralis Major", "Pectoralis Minor"],
  "Back" => ["Latissimus Dorsi", "Trapezius", "Rhomboids", "Erector Spinae", "Teres Major", "Infraspinatus"],
  "Shoulders" => ["Anterior Deltoid", "Lateral Deltoid", "Posterior Deltoid"],
  "Arms" => ["Biceps Brachii", "Brachialis", "Brachioradialis", "Triceps Brachii"],
  "Forearms" => ["Flexor Carpi Radialis", "Extensor Carpi Radialis", "Pronator Teres", "Supinator"],
  "Core" => ["Rectus Abdominis", "Transverse Abdominis", "External Obliques", "Internal Obliques", "Quadratus Lumborum"],
  "Glutes" => ["Gluteus Maximus", "Gluteus Medius", "Gluteus Minimus"],
  "Thighs" => ["Rectus Femoris", "Vastus Lateralis", "Vastus Medialis", "Vastus Intermedius", "Biceps Femoris", "Semitendinosus", "Semimembranosus", "Adductors", "Sartorius"],
  "Calves" => ["Gastrocnemius", "Soleus", "Tibialis Anterior"]
}

# Create Muscle Groups and Muscles
muscle_groups.each do |group_name, muscles|
  mg = MuscleGroup.create!(name: group_name)
  muscles.each { |muscle| Muscle.create!(name: muscle, muscle_group: mg) }
end

# Helper method to find muscles by name
def find_muscles(*names)
  Muscle.where(name: names)
end

# Define Exercises
exercises = [
  { name: "Bench Press", primary: "Pectoralis Major", secondary: ["Anterior Deltoid", "Triceps Brachii"], muscle_group: "Chest" },
  { name: "Deadlift", primary: "Erector Spinae", secondary: ["Gluteus Maximus", "Biceps Femoris", "Trapezius"], muscle_group: "Back" },
  { name: "Squat", primary: "Rectus Femoris", secondary: ["Gluteus Maximus", "Biceps Femoris", "Rectus Abdominis"], muscle_group: "Thighs" },
  { name: "Pull-Ups", primary: "Latissimus Dorsi", secondary: ["Biceps Brachii", "Rhomboids"], muscle_group: "Back" },
  { name: "Shoulder Press", primary: "Anterior Deltoid", secondary: ["Triceps Brachii", "Lateral Deltoid"], muscle_group: "Shoulders" },
  { name: "Barbell Curl", primary: "Biceps Brachii", secondary: ["Brachialis", "Brachioradialis"], muscle_group: "Arms" },
  { name: "Triceps Dips", primary: "Triceps Brachii", secondary: ["Anterior Deltoid", "Pectoralis Major"], muscle_group: "Arms" },
  { name: "Plank", primary: "Rectus Abdominis", secondary: ["Transverse Abdominis", "External Obliques"], muscle_group: "Core" },
  { name: "Calf Raise", primary: "Gastrocnemius", secondary: ["Soleus"], muscle_group: "Calves" }
]

# Create Exercises
exercises.each do |ex|
  byebug
  Exercise.create!(
    name: ex[:name],
    muscle_group: MuscleGroup.find_by(name: ex[:muscle_group]),
    primary_muscle: Muscle.find_by(name: ex[:primary]),
    secondary_muscles: find_muscles(*ex[:secondary]) # Assign array of Muscle objects, not strings
  )
end

# Create some template workouts
templates = [
  {
    name: "Beginner Full Body",
    description: "Basic full body workout for beginners",
    is_template: true,
    exercises: [
      { id: 1, sets: 3, reps: 10, notes: "Focus on form" },
      { id: 2, sets: 3, reps: 12, notes: "Controlled movement" }
    ]
  },
  {
    name: "Upper Body Power",
    description: "Advanced upper body strength workout",
    is_template: true,
    exercises: [
      { id: 3, sets: 4, reps: 8, notes: "Heavy weight" },
      { id: 4, sets: 3, reps: 12, notes: "Superset with next exercise" }
    ]
  }
]

templates.each do |template|
  plan = WorkoutPlan.create!(
    name: template[:name],
    description: template[:description],
    is_template: true,
    user: User.first # or create an admin user
  )
  
  template[:exercises].each do |exercise_data|
    plan.workout_plan_exercises.create!(
      exercise_id: exercise_data[:id],
      recommended_sets: exercise_data[:sets],
      recommended_reps: exercise_data[:reps],
      notes: exercise_data[:notes]
    )
  end
end

puts "✅ Seed data successfully created!"