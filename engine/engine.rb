require "json"
require "sinatra"
require "sinatra/reloader"

class Person
  @@people = []

  def self.add(name)
    @@people << name
  end

  def self.list
    @@people
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
end

class World
  @@w = 0
  @@h = 0

  def self.width=(width)
    @@w = width
  end

  def self.width
    @@w
  end

  def self.height=(height)
    @@h = height
  end

  def self.height
    @@h
  end
end

post "/world" do
  World.width = params[:w].to_i
  World.height = params[:h].to_i
  { w: World.width, h: World.height }.to_json
end

get "/world" do
  { w: World.width, h: World.height }.to_json
end

post "/people" do
  person = Person.new(params[:name], params[:x], params[:y])
  Person.add(person)
  person.attributes.to_json
end

get "/people/:id" do
  Person.list.detect { |person| person.name == params[:id] }.attributes.to_json
end

post "/people/:id/target" do
  { x: rand(World.width), y: rand(World.height) }.to_json
end
