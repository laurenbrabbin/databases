require 'database_connection'
require 'cohort_repository'

DatabaseConnection.connect('student_directory_2_test')

cohort_repository = CohortRepository.new

p cohort_repository.find_with_students(1)