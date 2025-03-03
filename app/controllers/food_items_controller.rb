class FoodItemsController < ApplicationController
    before_action :set_meal

    def index
        food_items = @meal.food_items
        if food_items
            render json: food_items
        else
            render json: { error: food_items.errors.full_message }, status: :unprocessable_entity
        end

    end

    def create
        food_item = @meal.food_items.build(food_item_params)
        if food_item.save
            render json: food_item, status: :created
        else
            render josn: { errors: food_item.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        
    end

    def destroy
        @food_item.destroy
        render json: { message: "Food item removed" },status: :no_content 
    end

    private

    def set_food_item
        @food_item = @meal.food_items.find_by(id: params[:id])
        render json: { error: "Food item not found" }, status: :not_found unless @food_item
    end

    def set_meal
        @meal = @current_user.meals.find_by(id: params[:meal_id])
    end

    def food_item_params
        params.require(:food_item).permit(:name, :quantity, :unit, :servings, :calories, :protein, :carbs, :fats)
    end
end
