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

  def self.all
    all_volunteers = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    all_volunteers.each do |volunteer|
      id = volunteer["id"].to_i
      name = volunteer["name"]
      project_id = volunteer["project_id"].to_i
      volunteers.push(Volunteer.new({id: id, name: name, project_id: project_id}))
    end
    volunteers
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{project_id}) RETURNING id;")
    @id = result.first["id"].to_i
  end

  def self.find(id)
    volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{id};").first
    if volunteer
      id = volunteer["id"]
      name = volunteer["name"]
      project_id = volunteer["project_id"].to_i
      Volunteer.new({id: id, name: name, project_id: project_id})
    else
      nil
    end
  end

end