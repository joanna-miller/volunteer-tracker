class Volunteer
  attr_reader :id
  attr_accessor :name, :project_id

  def initialize(attrs)
    @id = attrs[:id]
    @name = attrs[:name]
    @project_id = attrs[:project_id]
  end

  def ==(volunteer_to_compare)
    if volunteer_to_compare != nil
      (self.name == volunteer_to_compare.name) && (self.project_id == volunteer_to_compare.project_id)    
    else
      false
    end
  end

end