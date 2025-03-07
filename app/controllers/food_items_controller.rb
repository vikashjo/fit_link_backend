class FoodItemsController < ApplicationController
    before_action :set_food_item, only: [:update, :destroy]

    def index
        food_items = FoodItem.all
        if food_items
            render json: food_items
        else
            render json: { error: food_items.errors.full_message }, status: :unprocessable_entity
        end

    end

    def create
        # food_item = FoodItem.create(food_item_params)
        # if food_item.save
        #     render json: food_item, status: :created
        # else
        #     render josn: { errors: food_item.errors.full_messages }, status: :unprocessable_entity
        # end

        # new_params = params.require(:food_item).permit(:name)

        # macros = AiFoodRecognitionService.get_macros(new_params[:name])

        food_name = params[:food_item][:name]
        macros = DeepSeekAPI.get_macros(food_name)

        if macros[:error]
            render json: { error: macros[:error] }, status: :unprocessable_entity
        else
            food_item = FoodItem.create(name: food_name, **macros)
            render json: food_item, status: :created
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
        @food_item = FoodItem.find_by(id: params[:id])
        render json: { error: "Food item not found" }, status: :not_found unless @food_item
    end

    def food_item_params
        params.require(:food_item).permit(:name, :calories, :protein, :carbs, :fats)
    end
end
