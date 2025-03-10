class MealsController < ApplicationController

    def index
        if params[:date].present?
            date = Date.parse(params[:date]) rescue nil
            meals = date ?  @current_user.meals.includes(:meal_type, food_entries: :food_item).where(meal_time: date.all_day) 
            : meals = @current_user.meals.includes(:meal_type, food_entries: :food_item)
        else

            meals = @current_user.meals.includes(:meal_type, food_entries: :food_item)
        end
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

    def macro_trends
        # Determine the range parameter (default to 'week')
        range = params[:range] || 'week'
        case range
        when 'week'
          start_date = Date.today.beginning_of_week
          end_date = Date.today.end_of_week
        when 'month'
          start_date = Date.today.beginning_of_month
          end_date = Date.today.end_of_month
        else
          # Fallback to week if unknown range provided
          start_date = Date.today.beginning_of_week
          end_date = Date.today.end_of_week
        end

        trends = {}
        (start_date..end_date).each do |date|
            trends[date] = { calories: 0 }
        end
    
        # Get meals within the specified range for the current user
        meals = @current_user.meals.where(meal_time: start_date..end_date)
        meals.each do |meal|
            date = meal.meal_time.to_date
            trends[date][:calories] += meal.total_macros["calories"].to_f
        end

        result = trends.map do |date, data|
            { date: date.strftime("%Y-%m-%d"), calories: data[:calories] }
        end.sort_by { |entry| entry[:date] }
    
        render json: result
    end

    private

    def meal_params
        params.require(:meal).permit(:meal_time, :meal_type_id, food_entries_attributes: [:food_item_id, :quantity, :unit, :servings])
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
