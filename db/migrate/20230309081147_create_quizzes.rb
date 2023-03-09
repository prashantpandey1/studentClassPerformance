# frozen_string_literal: true

class CreateQuizzes < ActiveRecord::Migration[7.0]
  def change
    create_table :quizzes do |t|
      t.string :name
      t.string :quiz_type
      t.boolean :completed
      t.integer :user_id
      t.index :user_id

      t.timestamps
    end
  end
end
