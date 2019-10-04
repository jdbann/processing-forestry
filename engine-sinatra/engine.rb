require "json"
require "sinatra"
require "sinatra/reloader"

require_relative "person.rb"
require_relative "tree.rb"
require_relative "log.rb"
require_relative "task.rb"
require_relative "task_list.rb"
require_relative "world.rb"

post "/world" do
  Tree.clear
  Log.clear
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

post "/logs" do
  log = Log.new(params[:x].to_i, params[:y].to_i, params[:quantity].to_i)
  Log.add(log)
  log.attributes.to_json
end

get "/logs" do
  Log.to_s
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

get "/people/:person_id/tasks" do
  person = Person.find(person[:id])
  { tasks: TaskList.tasks_for(person).take(5) }.to_json
end

post "/people/:person_id/tasks" do
  TaskList.remove(params[:id])
  201
end

post "/people/:person_id/tasks/:task_id/impossible" do
  person = Person.find(params[:person_id])
  task = TaskList.find(params[:task_id])
  task.impossible_for(person)
  201
end

get "/tasks" do
  { tasks: TaskList.tasks.take(5) }.to_json
end
