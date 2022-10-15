class Book
  attr_reader :rentals, :id
  attr_accessor :title, :author

  # has_many :rentals
  # has_many :persons, through: rentals

  def initialize(title, author)
    @id = Random.rand(1..1000)
    @title = title
    @author = author
    @rentals = rentals
  end

  def add_rental(person, date)
    Rental.new(date, self, person)
  end
end
