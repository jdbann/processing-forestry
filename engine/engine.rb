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
    task = {
      x: tree.x,
      y: tree.y,
      id: "tree_#{tree.x}_#{tree.y}",
      type: "chopTree",
    }
    TaskList.add(task)
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

  def self.set_size(width, height)
    @@w = width.to_i
    @@h = height.to_i
    sweep_for_trees
  end

  def self.sweep_for_trees
    @@w.times do |x|
      @@h.times do |y|
        new_y = x.even? ? y : @@h - y
        task = { type: "walk", id: "#{x}_#{new_y}", x: x, y: new_y }
        TaskList.add(task)
      end
    end
  end
end

class TaskList
  @@tasks = []

  def self.add(new_task)
    return if @@tasks.any? { |task| task[:id] == new_task[:id] }

    @@tasks << new_task
  end

  def self.tasks
    @@tasks
  end

  def self.clear
    @@tasks = []
  end

  def self.remove(id)
    @@tasks = @@tasks.reject do |task|
      task[:id] == id
    end
  end
end

post "/world" do
  Tree.clear
  Person.clear
  TaskList.clear
  World.set_size(params[:w], params[:h])
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

get "/people/:person_id" do
  Person.list.detect do |person|
    person.name == params[:person_id]
  end.attributes.to_json
end

post "/people/:person_id/tasks" do
  TaskList.remove(params[:id])
  201
end

get "/tasks" do
  { tasks: TaskList.tasks.take(60) }.to_json
end
