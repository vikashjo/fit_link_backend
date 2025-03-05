class FoodEntriesController < ApplicationController
  before_action :set_meal

  def create
    food_entry = @meal.food_entries.build(food_entry_params)
    if food_entry.save
      render json: food_entry.as_json(include: :food_item), status: :created
    else
      render json: { errors: food_entry.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    food_entry = @meal.food_entries.find_by(id: params[:id])
    if food_entry.destroy
      render json: { message: "Entry deleted successfully"}
    else
      render json: { errors: food_entry.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_meal
    @meal = @current_user.meals.find_by(id: params[:meal_id])
  end

  def food_entry_params
    params.require(:food_entry).permit(:quantity, :food_item_id, :unit, :servings)
  end
end
