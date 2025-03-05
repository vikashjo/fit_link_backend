class MealTypesController < ApplicationController

  def index
    @meal_types = MealType.all
    render json: @meal_types
  end

  def create
    meal_type = MealType.create(meal_type_params)
    if meal_type.save
      render json: meal_type, status: :created
    else
      render json: { errors: meal_type.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  private

  def meal_type_params
    params.require(:meal_type).permit(:name, :description, :default_time, :main_meal, recommended_macros: {})
  end
end

