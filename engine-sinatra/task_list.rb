class TaskList
  @@tasks = []

  def self.add(new_task)
    @@tasks << new_task
    @@tasks.uniq!
  end

  def self.find(id)
    tasks.detect do |task|
      task.id == id
    end
  end

  def self.tasks
    @@tasks.sort_by(&:type).select do |task|
      if task.type == "moveLog" && task.data[:log_x] == 0 && task.data[:log_y] == 0
        false
      else
        true
      end
    end
  end

  def self.tasks_for(person)
    tasks.select do |task|
      task.possible_for?(person)
    end
  end

  def self.clear
    @@tasks = []
  end

  def self.remove(id)
    @@tasks = @@tasks.reject do |task|
      task.id == id
    end
  end
end
