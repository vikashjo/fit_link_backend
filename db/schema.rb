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

ActiveRecord::Schema[7.1].define(version: 2025_02_25_080235) do
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
  add_foreign_key "muscles", "muscle_groups"
  add_foreign_key "setts", "exercises"
  add_foreign_key "setts", "workouts"
  add_foreign_key "workout_plan_exercises", "exercises"
  add_foreign_key "workout_plan_exercises", "workout_plans"
  add_foreign_key "workout_plans", "users"
  add_foreign_key "workouts", "users"
end
