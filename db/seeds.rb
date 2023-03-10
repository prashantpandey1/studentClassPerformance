# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user_json = File.read(Rails.root.join('db/data/users.json'))
user_hash = JSON.parse(user_json)
user_hash.each do |data|
  next if User.exists?(id: data['id'])

  User.create!(
    id: data['id'],
    first_name: data['first_name'],
    last_name: data['last_name'],
    email: data['email'],
    sign_up_date: data['sign_up_date'],
    created_at: data['created_at'],
    updated_at: data['updated_at']
  )
end

# Read the data from Quiz json file and update in Quiz table
quiz_json = File.read(Rails.root.join('db/data/quizzes.json'))
quiz_hash = JSON.parse(quiz_json)
quiz_hash.each do |data|
  next if Quiz.exists?(id: data['id'])

  Quiz.create!(
    id: data['id'],
    name: data['name'],
    quiz_type: data['quiz_type'],
    completed: data['completed'],
    user_id: data['user_id'],
    created_at: data['created_at'],
    updated_at: data['updated_at']
  )
end

# Read the data from Question json file and update in Question table
question_json = File.read(Rails.root.join('db/data/questions.json'))
question_hash = JSON.parse(question_json)
question_hash.each do |data|
  next if Question.exists?(id: data['id'])

  Question.create!(
    id: data['id'],
    text: data['text'],
    subject: data['subject'],
    correct_answer: data['correct_answer'],
    created_at: data['created_at'],
    updated_at: data['updated_at']
  )
end

# Read the data from Response json file and update in Response table
response_json = File.read(Rails.root.join('db/data/responses.json'))
response_hash = JSON.parse(response_json)
response_hash.each do |data|
  next if Response.exists?(id: data['id'])

  Response.create!(
    id: data['id'],
    correct: data['correct'],
    quiz_id: data['quiz_id'],
    question_id: data['question_id'],
    created_at: data['created_at'],
    updated_at: data['updated_at']
  )
end
