class MealsController < ApplicationController

    def index
        meals = @current_user.meals.includes(:food_items)
        render json: meals.map { |meal| meal_with_macros(meal)}
    end

    def create
        meal = @current_user.meals.new(meal_params)
        if meal.save
            render json: meal, status: :created
        else
            render json: { errors: meal.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        meal = @current_user.meals(params[:id])
        if meal.update(meal_params)
            render json: meal, status: :ok
        else
            render json: { errors: meal.errors.full_messages }, status: :ok
        end
    end

    def destroy
        meal = @current_user.meals(params[:id])
        if meal.destroy
            render json: { message: "Meal is successfully removed" }, status: ok
        else
            render json: { errors: meal.errors.full_messages },status: :unprocessable_entity
        end

    end

    private

    def meal_params
        params.require(:meal).permit(:name, :meal_time)
    end

    def meal_with_macros(meal)
        meal.as_json.merge(total_macros: meal.total_macros)
    end

end
