require_relative './cohort'
require_relative './student'
require_relative './database_connection'

class CohortRepository
  def find_with_students(id)
    sql = 'SELECT cohorts.id,
                  cohorts.name,
                  cohorts.start_date,
                  students.id AS student_id,
                  students.name AS student_name
            FROM cohorts
            JOIN students ON students.cohort_id = cohorts.id
            WHERE cohorts.id = $1;'

    sql_params = [id]

    result = DatabaseConnection.exec_params(sql, sql_params)
  

    cohort = Cohort.new

    cohort.id = result.first['id']
    cohort.name = result.first['name']
    cohort.start_date = result.first['start_date']

    result.each do |record|
      student = Student.new
      student.id = record['student_ID']
      student.name = record['student_name']

      cohort.students << student
    end

    return cohort
  end
end