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
        task = Task.new("#{x}_#{new_y}", "walk", { x: x, y: new_y })
        TaskList.add(task)
      end
    end
  end
end
