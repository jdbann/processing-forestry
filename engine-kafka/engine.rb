require "json"
require "kafka"
require "sinatra"
require "sinatra/reloader"

class Producer
  def self.produce(event_name, params)
    producer.
      produce({ type: event_name, data: params }.to_json, topic: "simulation")
  end

  def self.producer
    @@producer ||= kafka.async_producer(
      delivery_threshold: 20,
      delivery_interval: 5,
    )
  end

  def self.kafka
    @@kafka ||= Kafka.new(["localhost:9092"], client_id: "engine")
  end
end

post "/world" do
  Producer.produce("worldStarted", width: params[:w], height: params[:h])
  201
end

post "/trees" do
  Producer.produce("treeFound", x: params[:x].to_i, y: params[:y].to_i)
  201
end

post "/logs" do
  Producer.produce(
    "logFound",
    x: params[:x].to_i,
    y: params[:y].to_i,
    quantity: params[:quantity].to_i,
  )
  201
end
