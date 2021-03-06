# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_03_26_080021) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.text "text"
    t.text "stem_text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "const_answers", force: :cascade do |t|
    t.text "text"
    t.string "vector"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "const_questions", force: :cascade do |t|
    t.text "text"
    t.string "vector"
    t.string "basics"
    t.integer "const_answer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["const_answer_id"], name: "index_const_questions_on_const_answer_id"
  end

  create_table "layers", force: :cascade do |t|
    t.integer "size_inputs"
    t.integer "size_outputs"
    t.string "weights"
    t.string "inputs"
    t.string "outputs"
    t.integer "perceptron_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["perceptron_id"], name: "index_layers_on_perceptron_id"
  end

  create_table "perceptrons", force: :cascade do |t|
    t.integer "size"
    t.float "coefficient"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "questions", force: :cascade do |t|
    t.text "text"
    t.text "stem_text"
    t.integer "answer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["answer_id"], name: "index_questions_on_answer_id"
  end

  create_table "words", force: :cascade do |t|
    t.string "value"
    t.string "vector"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
