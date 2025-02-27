class SettsController < ApplicationController

  def index
    
    @setts = @current_user.setts

    if @setts.any?
      render json: @setts, status: :ok
    else
      render json: { message: 'No setts found' }, status: :ok
    end
  end

  def create
    byebug
    @sett  = @current_user.setts.new(sett_params)
    if @sett.save
      render json: @sett, status: :created
    else
      render json: { errors: @sett.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def sett_params
    params.require(:sett).permit(:reps, :weight, :set, :hit, :exercise_id, workout_id)
  end
end
