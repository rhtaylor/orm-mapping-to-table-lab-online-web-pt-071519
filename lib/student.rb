class Student
  attr_accessor :name, :grade
  attr_reader :id
  def initialize(name, grade, id = nil )
    @name = name
    @grade = grade
  end
   #Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  def self.create_table
    sql = <<-BOOM
        CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
        )
            BOOM
    DB[:conn].execute(sql)
  end
  def self.drop_table
      drop = <<-drop
        DROP TABLE IF EXISTS students
                drop
    DB[:conn].execute(drop)
  end

  def save
      sql = <<-BOMB
      INSERT INTO students (name, grade)
      VALUES ( ?, ? )
              BOMB
      DB[:conn].execute(sql, self.name, self.grade)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

def self.create(name:, grade:)
  student = Student.new(name, grade)
  student.save
  student
end

end
