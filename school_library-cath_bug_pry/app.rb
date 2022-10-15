require './person'
require './rental'
require 'date'
require './classroom'
require './teacher'
require './student'
require './book'

class App
  def initialize
    @rentals = []
    @people = []
    @books = []
    @teachers = []
    @students = []
  end

  def list_books
    if @books.length.positive?
      @books.each_with_index do |book, i|
        p " book number: #{i}, ID: #{book.id}, Title: #{book.title}, Author: #{book.author}"
      end
    else
      p 'books not found'
    end
  end

  def list_people
    if @people.length.positive?
      @people.each_with_index do |person, i|
        p "person number: #{i}, ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
      end
    else
      p 'persons not found'
    end
  end

  def rent_list_by_id
    if @rentals.length.positive?
      p('select Person ID in the List below')
      list_people
      p 'Type person ID:'
      id = gets.chomp

      @rentals.select do |rent|
        if rent.person.id == id.to_i
          p "Date: #{rent.date}, Book '#{rent.book.title}', Author #{rent.book.author}"
        else
          p 'Rental not found for the selected person '
        end
      end
    else
      p 'Rental not found'
    end
  end

  def create_person
    p 'For student type (1), for teacher tyep (2)'
    input = gets.chomp
    case input.to_i
    when 1
      create_student_option
    when 2
      create_teacher_option
    else
      p 'invalid input!!! For student type (1), for teacher tyep (2)'
    end
  end

  def create_student(classroom, age, name, parent_permission)
    student = Student.new(classroom, age, name, parent_permission: parent_permission)
    @people.push(student)
  end

  def create_teacher(specialization, age, name)
    teacher = Teacher.new(specialization, age, name)
    @people.push(teacher)
  end

  def create_student_option
    p ' type student Name : '
    name = gets.chomp
    p ' type student Age : '
    age = gets.chomp
    p ' type student Classroom <number> : '
    classroom = gets.chomp
    parent_permission = true
    permission?(parent_permission)
    create_student(classroom.to_i, age.to_i, name, parent_permission)
    p " student #{name} has been added successfully!!!"
  end

  def create_teacher_option
    p 'type teacher name:'
    name = gets.chomp
    p 'type teacher age:'
    age = gets.chomp
    p 'type teacher specialization:'
    specialization = gets.chomp
    create_teacher(specialization, age.to_i, name)
    p "Teacher #{name} has been added successfully!!!"
  end

  def create_new_book
    p ' type Book Title : '
    title = gets.chomp
    p ' type Book Author : '
    author = gets.chomp
    book = Book.new(title, author, 2)
    binding.pry
    @books.push(book)
    p "Book #{title} has been added successfully!!!"
  end

  def create_rental
    p ' Select a Book number in the list below'
    list_books
    p ' type book number : '
    book_number = gets.chomp
    p 'Select a Person number in the list below'
    list_people
    person_number = gets.chomp
    p ' type the Date in this format, for example: (2000/01/01) : '
    date = conver_date(gets)

    book = @books[book_number.to_i]
    people = @people[person_number.to_i]

    rent = Rental.new(date, book, people)
    @rentals.push(rent)
    p 'Rental has been added successfully!!!'
  end

  def permission?(parent_permission)
    p 'Has parent permission? type Y to yes and N to no: '
    permission = gets.chomp
    case permission
    when 'n', 'N'
      !parent_permission
    when 'y', 'Y'
      parent_permission
    else
      permission?(parent_permission)
    end
  end

  def conver_date(date)
    Date.parse(date)
  end
end
