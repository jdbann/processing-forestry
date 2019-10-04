class Log
  @@logs = []

  attr_accessor :x, :y, :quantity

  def self.add(log)
    @@logs << log
  end

  def self.clear
    @@logs = []
  end

  def self.to_s
    World.width.times.map do |x|
      World.height.times.map do |y|
        if @@logs.detect { |t| t.x == x && t.y == y }
          "L"
        else
          " "
        end
      end.join("")
    end.join("\n")
  end

  def initialize(x_position, y_position, quantity)
    self.x = x_position
    self.y = y_position
    self.quantity = quantity
  end

  def attributes
    { x: x, y: y, quantity: quantity }
  end
end
