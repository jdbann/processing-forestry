require "json"
require "sinatra"
require "sinatra/reloader"

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

class Tree
  @@trees = []

  attr_accessor :x, :y

  def self.add(tree)
    @@trees << tree
  end

  def self.clear
    @@trees = []
  end

  def self.to_s
    World.width.times.map do |x|
      World.height.times.map do |y|
        if @@trees.detect { |t| t.x == x && t.y == y }
          "T"
        else
          " "
        end
      end.join("")
    end.join("\n")
  end

  def initialize(x_position, y_position)
    self.x = x_position
    self.y = y_position
  end

  def attributes
    { x: x, y: y }
  end
end

class World
  @@w = 1
  @@h = 1

  @@sweeper = [{ x: 0, y: 0 }]

  def self.width=(width)
    @@w = width
    reset_sweeper
  end

  def self.width
    @@w
  end

  def self.height=(height)
    @@h = height
    reset_sweeper
  end

  def self.height
    @@h
  end

  def self.reset_sweeper
    @@sweeper = @@w.times.map do |x|
      locations = @@h.times.map do |y|
        { x: x, y: y }
      end
      x.even? ? locations : locations.reverse
    end.flatten
  end

  def self.sweep
    @@sweeper.pop || reset_sweeper && sweep
  end
end

post "/world" do
  Tree.clear
  Person.clear
  World.width = params[:w].to_i
  World.height = params[:h].to_i
  { w: World.width, h: World.height }.to_json
end

get "/world" do
  { w: World.width, h: World.height }.to_json
end

post "/trees" do
  tree = Tree.new(params[:x].to_i, params[:y].to_i)
  Tree.add(tree)
  tree.attributes.to_json
end

get "/trees" do
  Tree.to_s
end

post "/people" do
  person = Person.new(params[:name], params[:x], params[:y])
  Person.add(person)
  person.attributes.to_json
end

get "/people/:id" do
  Person.list.detect { |person| person.name == params[:id] }.attributes.to_json
end

get "/tasks" do
  { tasks: [
    World.sweep.merge(type: "walk"),
  ] }.to_json
end
