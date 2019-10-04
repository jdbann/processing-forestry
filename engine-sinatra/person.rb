class Person
  @@people = []

  def self.add(name)
    @@people << name
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

  def initialize(name, x_position, y_position)
    @name = name
    @x = x_position
    @y = y_position
  end

  attr_reader :name

  def attributes
    { name: @name, x: @x, y: @y }
  end

  def ==(person)
    name == person.name
  end
end
