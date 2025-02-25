class WorkoutPlansController < ApplicationController
  def index
    @workout_plans = if params[:templates]
      WorkoutPlan.templates
    else
      @current_user.workout_plans.user_workouts
    end
    
    render json: @workout_plans
  end

  def create
    byebug
    @workout_plan = @current_user.workout_plans.build(workout_plan_params)
    
    if @workout_plan.save
      render json: @workout_plan, status: :created
    else
      render json: { errors: @workout_plan.errors }, status: :unprocessable_entity
    end
  end

  def show
    @workout_plan = WorkoutPlan.find(params[:id])
    render json: @workout_plan, include: { 
      workout_plan_exercises: { 
        include: :exercise 
      }
    }
  end

  def clone_template
    template = WorkoutPlan.templates.find(params[:id])
    @workout_plan = @current_user.workout_plans.new(
      name: template.name,
      description: template.description,
      is_template: false
    )

    if @workout_plan.save
      # Clone the exercises from template
      template.workout_plan_exercises.each do |template_exercise|
        @workout_plan.workout_plan_exercises.create!(
          exercise: template_exercise.exercise,
          recommended_sets: template_exercise.recommended_sets,
          recommended_reps: template_exercise.recommended_reps,
          notes: template_exercise.notes
        )
      end
      render json: @workout_plan, status: :created
    else
      render json: { errors: @workout_plan.errors }, status: :unprocessable_entity
    end
  end

  private

  def workout_plan_params
    params.require(:workout_plan).permit(
      :name, 
      :description, 
      :is_template,
      workout_plan_exercises_attributes: [
        :exercise_id,
        :recommended_sets,
        :recommended_reps,
        :notes
      ]
    )
  end
end 