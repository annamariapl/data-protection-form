# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_07_16_180058) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agreement_answers", force: :cascade do |t|
    t.bigint "answer_id"
    t.bigint "agreement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agreement_id"], name: "index_agreement_answers_on_agreement_id"
    t.index ["answer_id"], name: "index_agreement_answers_on_answer_id"
  end

  create_table "agreement_templates", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "agreements", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "question_id"
    t.string "title"
    t.string "sentence"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pointing"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "chapters", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "agreement_template_id"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "chapter_id"
    t.index ["agreement_template_id"], name: "index_questions_on_agreement_template_id"
    t.index ["chapter_id"], name: "index_questions_on_chapter_id"
  end

  add_foreign_key "agreement_answers", "agreements"
  add_foreign_key "agreement_answers", "answers"
  add_foreign_key "answers", "questions"
  add_foreign_key "questions", "agreement_templates"
  add_foreign_key "questions", "chapters"
end
