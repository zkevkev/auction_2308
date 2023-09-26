class Attendee
  attr_reader :name, :budget

  def initialize(details)
    @name = details[:name]
    @budget = details[:budget]
  end
end