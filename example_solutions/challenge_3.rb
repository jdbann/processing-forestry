require "sinatra"

get "/people/*/tasks" do
  response = {
    tasks: [
      {
        type: "walk",
        id: "anything",
        x: rand(30),
        y: rand(30),
      },
    ],
  }
  [200, response.to_json]
end
