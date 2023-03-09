# frozen_string_literal: true

class CreateResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :responses do |t|
      t.boolean :correct
      t.integer :quiz_id
      t.integer :question_id
      t.index :quiz_id
      t.index :question_id

      t.timestamps
    end
  end
end
