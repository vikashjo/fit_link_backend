# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_03_04_072149) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exercise_muscles", force: :cascade do |t|
    t.bigint "exercise_id", null: false
    t.bigint "muscle_id", null: false
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_exercise_muscles_on_exercise_id"
    t.index ["muscle_id"], name: "index_exercise_muscles_on_muscle_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "muscle_group_id", null: false
    t.bigint "primary_muscle_id"
    t.string "secondary_muscles", default: [], array: true
    t.index ["muscle_group_id"], name: "index_exercises_on_muscle_group_id"
    t.index ["primary_muscle_id"], name: "index_exercises_on_primary_muscle_id"
  end

  create_table "food_entries", force: :cascade do |t|
    t.integer "quantity", null: false
    t.bigint "food_item_id", null: false
    t.string "unit", null: false
    t.integer "servings", default: 1
    t.bigint "meal_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_item_id"], name: "index_food_entries_on_food_item_id"
    t.index ["meal_id"], name: "index_food_entries_on_meal_id"
  end

  create_table "food_items", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "calories", precision: 10, scale: 2
    t.decimal "protein", precision: 10, scale: 2
    t.decimal "carbs", precision: 10, scale: 2
    t.decimal "fats", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "macro_goals", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "calories", null: false
    t.integer "protein", null: false
    t.integer "carbs", null: false
    t.integer "fats", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_macro_goals_on_user_id"
  end

  create_table "meal_types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "default_time"
    t.boolean "main_meal"
    t.jsonb "recommended_macros", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meals", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "meal_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "meal_type_id", null: false
    t.index ["meal_type_id"], name: "index_meals_on_meal_type_id"
    t.index ["user_id"], name: "index_meals_on_user_id"
  end

  create_table "muscle_groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "muscles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "muscle_group_id", null: false
    t.index ["muscle_group_id"], name: "index_muscles_on_muscle_group_id"
  end

  create_table "setts", force: :cascade do |t|
    t.bigint "exercise_id", null: false
    t.bigint "workout_id", null: false
    t.integer "reps"
    t.integer "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "set"
    t.boolean "hit"
    t.index ["exercise_id"], name: "index_setts_on_exercise_id"
    t.index ["workout_id"], name: "index_setts_on_workout_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email"
    t.integer "weight", null: false
    t.integer "height", null: false
    t.string "goal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.integer "age", default: 18, null: false
    t.string "gender"
    t.string "activity_level"
  end

  create_table "workout_plan_exercises", force: :cascade do |t|
    t.bigint "workout_plan_id", null: false
    t.bigint "exercise_id", null: false
    t.integer "recommended_sets"
    t.integer "recommended_reps"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_workout_plan_exercises_on_exercise_id"
    t.index ["workout_plan_id"], name: "index_workout_plan_exercises_on_workout_plan_id"
  end

  create_table "workout_plans", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_template", default: false
    t.index ["is_template"], name: "index_workout_plans_on_is_template"
    t.index ["user_id"], name: "index_workout_plans_on_user_id"
  end

  create_table "workouts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "date"
    t.text "notes"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_workouts_on_user_id"
  end

  add_foreign_key "exercise_muscles", "exercises"
  add_foreign_key "exercise_muscles", "muscles"
  add_foreign_key "exercises", "muscle_groups"
  add_foreign_key "exercises", "muscles", column: "primary_muscle_id"
  add_foreign_key "food_entries", "food_items"
  add_foreign_key "food_entries", "meals"
  add_foreign_key "macro_goals", "users"
  add_foreign_key "meals", "meal_types"
  add_foreign_key "meals", "users"
  add_foreign_key "muscles", "muscle_groups"
  add_foreign_key "setts", "exercises"
  add_foreign_key "setts", "workouts"
  add_foreign_key "workout_plan_exercises", "exercises"
  add_foreign_key "workout_plan_exercises", "workout_plans"
  add_foreign_key "workout_plans", "users"
  add_foreign_key "workouts", "users"
end
