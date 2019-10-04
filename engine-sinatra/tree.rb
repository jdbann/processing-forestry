class Tree
  @@trees = []

  attr_accessor :x, :y

  def self.add(tree)
    @@trees << tree
    task = Task.new(
      "tree_#{tree.x}_#{tree.y}",
      "chopTree",
      x: tree.x,
      y: tree.y,
    )
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
