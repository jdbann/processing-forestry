class Person
  @@people = []

  def self.add(id)
    @@people << id
  end

  def self.clear
    @@people = []
  end

  def self.list
    @@people
  end

  def self.find(id)
    @@people.detect do |person|
      person.id == id
    end
  end

  def initialize(id, x_position, y_position)
    @id = id
    @x = x_position
    @y = y_position
  end

  attr_reader :id

  def attributes
    { id: @id, x: @x, y: @y }
  end

  def ==(person)
    id == person.id
  end
end
