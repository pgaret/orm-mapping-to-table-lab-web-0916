# Remember, you can access your database connection anywhere in this class
#  with DB[:conn]
class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
  end

  def self.create_table
    DB[:conn].execute("CREATE TABLE students(id INTEGER PRIMARY KEY, name TEXT, grade TEXT)")
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students")
  end

  def save
    DB[:conn].execute("INSERT INTO students (name, grade) VALUES ('#{self.name}', '#{self.grade}')")
  #  print DB[:conn].execute("SELECT * FROM students")
  # changes made
    @id = DB[:conn].execute("SELECT MAX(id) FROM students").flatten[0]
  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end
end
