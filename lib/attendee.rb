class Attendee
  attr_reader :name
  attr_accessor :budget

  def initialize(details)
    @name = details[:name]
    @budget = details[:budget].gsub('$', '').to_i
  end
end