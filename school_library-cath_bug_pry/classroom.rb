class Classroom
  attr_accessor :label, :students

  # has_many :students

  def initialize(label)
    @label = label
  end

  def add_student(student)
    student.classroom = self
  end
end
