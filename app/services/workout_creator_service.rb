class WorkoutCreatorService
  def initialize(user, params)
    @user = user
    @params = params
  end

  def call
    ActiveRecord::Base.transaction do
      create_workout
      create_exercise_sets
    end
  end

  private

  def create_workout
    # Workout creation logic
  end

  def create_exercise_sets
    # Sets creation logic
  end
end