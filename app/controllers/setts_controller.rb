class SettsController < ApplicationController
  def index
    @setts = @current_user.setts
    render json: @setts, status: :ok
  end

  def create
    @sett  = @current_user.setts.new(sett_params)
    if @sett.save
      render json: @sett, status: :created
    else
      render json: { errors: @sett.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def sett_params
    params.require(:sett).permit(:reps, :weight, :date)
  end
end
