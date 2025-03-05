class MealsController < ApplicationController

    def index
        meals = @current_user.meals.includes(:meal_type, food_entries: :food_item)
        render json: meals.map { |meal| meal_with_macros(meal)}
    end

    def create
        meal = @current_user.meals.new(meal_params)
        if meal.save
            render json: meal.as_json(include: :meal_type), status: :created
        else
            render json: { errors: meal.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        meal = @current_user.meals(params[:id])
        if meal.update(meal_params)
            render json: meal.as_json(include: :meal_type), status: :ok
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
        params.require(:meal).permit(:meal_time, :meal_type_id)
    end

    def meal_with_macros(meal)
        # meal.as_json.merge(total_macros: meal.total_macros)

        {
            id: meal.id,
            meal_time: meal.meal_time,
            meal_type: {
                name: meal.meal_type.name,
            },
            total_macros: meal.total_macros,
            food_entries: meal.food_entries.map do |entry|
            {
                food_item: {
                    name: entry.food_item.name
                },
                servings: entry.servings
            }
            end
        }
    end

end
