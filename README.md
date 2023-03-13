# README

Things you may want to cover:

* Ruby version -- 3.2.0

* Rails version -- 7.0.4.2

* add gem 'kaminari' in Gemfile for pagination

* Run the command 'bundle install'

* create three endpoints:
    - students_performance
       This endpoint should return a paginated JSON response of user records in batches of 10, with the user’s overall correct response average expressed as a percentage. The endpoint should also take a parameter indicating whether to return results for practice or test mode quizzes.
    - subjects_performance
       should return a JSON response of each subject containing breakdowns of user response correct average for the given subject.
    - class_performance
       should return overall data for the class performance: all user average for test, all user average for practice, total quizzes taken and total questions (responses) answered.

* For all three endpoints, it is assumed that only completed quizzes are considered when calculating performance.    

* create Model, Controller and Service object for these API's

* create mixin and add a method to calculate performance average

* Add 'include MixinName' in service objects and use the average method.
