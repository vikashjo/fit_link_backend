class AddTemplateToWorkoutPlans < ActiveRecord::Migration[7.0]
  def change
    add_column :workout_plans, :is_template, :boolean, default: false
    add_index :workout_plans, :is_template
  end
end 