class TaskList
  @@tasks = []

  def self.add(new_task)
    @@tasks << new_task
    @@tasks.uniq!
  end

  def self.tasks
    @@tasks.sort_by(&:type)
  end

  def self.tasks_for(person)
    tasks.filter do |task|
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
