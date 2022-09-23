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

ActiveRecord::Schema[7.0].define(version: 2022_09_23_002858) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "user_answer_id"
    t.bigint "round_id", null: false
    t.bigint "question_id", null: false
    t.boolean "correct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["round_id"], name: "index_answers_on_round_id"
    t.index ["user_answer_id"], name: "index_answers_on_user_answer_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "icon_name"
  end

  create_table "options", force: :cascade do |t|
    t.string "content"
    t.bigint "question_id", null: false
    t.string "letter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_options_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "content"
    t.string "answer"
    t.integer "usual_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "game_id", null: false
    t.index ["game_id"], name: "index_questions_on_game_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "game_id", null: false
    t.datetime "elapsed_time"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_rounds_on_game_id"
    t.index ["user_id"], name: "index_rounds_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_number"
    t.string "country"
    t.string "role"
    t.string "image_url"
    t.string "state"
    t.string "city"
    t.string "street"
    t.string "street_number"
    t.string "first_name"
    t.string "last_name"
    t.float "latitude"
    t.float "longitude"
    t.string "language"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answers", "options", column: "user_answer_id"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "rounds"
  add_foreign_key "options", "questions"
  add_foreign_key "questions", "games"
  add_foreign_key "rounds", "games"
  add_foreign_key "rounds", "users"
end
