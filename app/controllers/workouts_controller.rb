class WorkoutsController < ApplicationController

  def index
    workouts = @current_user.workouts.includes(sets: :exercise)
    render json: workouts, include: { sets: { include: :exercise } }
  end

  # Fetch a single workout with exercises and sets
  def show
    workout = @current_user.workouts.includes(sets: :exercise).find(params[:id])
    render json: workout, include: { sets: { include: :exercise } }
  end
  
  def create
    @workout = @current_user.workouts.build(workout_params)
    
    if params[:workout_plan_id].present?
      workout_plan = WorkoutPlan.find_by(params[:workout_plan_id])

      if workout_plan
        copy_exercises_from_plan(workout_plan)
      else
        render json: { error: 'Workout plan not found' }, status: :not_found
        return
      end
    end
    
    if @workout.save
      render json: @workout, status: :created
    else
      render json: { errors: @workout.errors }, status: :unprocessable_entity
    end
  end

  private

  def copy_exercises_from_plan(workout_plan)
    workout_plan.workout_plan_exercises.each do |plan_exercise|
      @workout.setts.build(
        exercise: plan_exercise.exercise,
        reps: plan_exercise.recommended_reps,
        sets: plan_exercise.recommended_sets
      )
    end
  end

  def workout_params
    params.require(:workout).permit(:name, :date)
  end
end 