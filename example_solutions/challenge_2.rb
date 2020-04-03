require "sinatra"

get "/people/:id/tasks" do
  [200, '{ "tasks": [] }']
end
