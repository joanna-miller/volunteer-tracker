class Volunteer
  attr_reader :id
  attr_accessor :name, :project_id

  def initialize(attrs)
    @id = attrs[:id]
    @name = attrs[:name]
    @project_id = attrs[:project_id]
  end

end