class Task
  attr_reader :id, :type, :data

  def initialize(id, type, **data)
    @id = id
    @type = type
    @data = data
    @impossible_for = []
  end

  def impossible_for(person)
    @impossible_for << person
    @impossible_for.uniq!
  end

  def possible_for?(person)
    @impossible_for.include?(person)
  end

  def ==(task)
    id == task.id
  end

  def to_json(*_args)
    data.merge(id: id, type: type).to_json
  end
end
