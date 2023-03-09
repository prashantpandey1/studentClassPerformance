# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :text
      t.string :subject
      t.string :correct_answer

      t.timestamps
    end
  end
end
