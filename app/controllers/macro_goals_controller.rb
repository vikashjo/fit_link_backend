class MacroGoalsController < ApplicationController

    def daily_progress 
       macro_goal = @current_user.macro_goal 
       meals = @current_user.meals.where(meal_time: Time.zone.today.all_day)
    

        total_macros = meals.map(&:total_macros).inject({ calories: 0, protein: 0, carbs: 0, fats: 0 }) do |sum, meal_macros|
            sum[:calories] += meal_macros[:calories]
            sum[:protein]  += meal_macros[:protein]
            sum[:carbs]    += meal_macros[:carbs]
            sum[:fats]     += meal_macros[:fats]
            sum
        end

        progress = {
        calories: ((total_macros[:calories] / macro_goal.calories.to_f) * 100).round,
        protein: ((total_macros[:protein] / macro_goal.protein.to_f) * 100).round,
        carbs: ((total_macros[:carbs] / macro_goal.carbs.to_f) * 100).round,
        fats: ((total_macros[:fats] / macro_goal.fats.to_f) * 100).round
        }

        render json: { total_macros: total_macros, macro_goal: macro_goal, progress: progress }

    end

    def show
        macro_goal = @current_user.macro_goal
        
        meals_today = @current_user.meals.where(meal_time: Time.zone.today.all_day)
        render json: macro_goal, status: :ok

    end

    def create
        goals = MacroGoal.calculate_bmr(@current_user)
        macro_goal = @current_user.build_macro_goal(goals)

        if macro_goal.save
            render json: macro_goal, status: :created
        else
            render json: { errors: macro_goal.errors.full_messages}, status: :unprocessable_entity
        end
    end

end
