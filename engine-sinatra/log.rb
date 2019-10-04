class Log
  @@logs = []

  attr_accessor :x, :y, :quantity

  def self.add(log)
    @@logs << log
    @@logs.uniq!
    task = Task.new(
      "log_#{log.x}_#{log.y}_logCount",
      "moveLog",
      log_x: log.x,
      log_y: log.y,
      drop_x: 0,
      drop_y: 0,
    )
    TaskList.add(task)
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

  def ==(log)
    x == log.x && y == log.y
  end

  def attributes
    { x: x, y: y, quantity: quantity }
  end
end
