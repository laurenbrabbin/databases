require_relative '../lib/cohort_repository.rb'

RSpec.describe CohortRepository do

  def reset_cohorts_table
    seed_sql = File.read('spec/seeds_cohorts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_2_test' })
    connection.exec(seed_sql)
  end

  before(:each) do #before each test do the above
    reset_cohorts_table
  end 

  it "finds all the students in a given cohort" do
    repo = CohortRepository.new

    cohort = repo.find_with_students(1) #find students in cohort 1
    p cohort 

    expect(cohort.name).to eq("Cohort1") 
    expect(cohort.start_date).to eq("Janurary") 
    expect(cohort.students.length).to eq(2)
    expect(cohort.students.first.name).to eq("Lauren") 
  end
  it "finds all the students in a given cohort" do
    repo = CohortRepository.new

    cohort = repo.find_with_students(3) #find students in cohort 1
    p cohort 

    expect(cohort.name).to eq("Cohort3") 
    expect(cohort.start_date).to eq("March") 
    expect(cohort.students.length).to eq(2)
    expect(cohort.students.first.name).to eq("Lucy") 
  end
end