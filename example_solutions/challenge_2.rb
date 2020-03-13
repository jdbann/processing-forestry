require "sinatra"

get "/**" do
  [200, '{ "tasks": [] }']
end
