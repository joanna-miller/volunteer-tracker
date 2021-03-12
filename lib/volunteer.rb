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
    all_volunteers = DB.exec("SELECT * FROM volunteers ORDER BY name;")
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

  def update(attrs)
    if (attrs.has_key?(:name)) && (attrs.fetch(:name) != nil)
      @name = attrs.fetch(:name)
      DB.exec("UPDATE volunteers SET name = '#{@name}' WHERE id = #{id};")
    end
    if (attrs.has_key?(:project_id)) && (attrs.fetch(:project_id) != nil)
      @project_id = attrs.fetch(:project_id)
      DB.exec("UPDATE volunteers SET project_id = '#{@project_id}' WHERE id = #{id};")
    end
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{@id};")
  end

  def self.search(name)
    searched_volunteers = DB.exec("SELECT * FROM volunteers WHERE name LIKE '#{name}%';")
    volunteers = []
    searched_volunteers.each do |volunteer|
      id = volunteer["id"].to_i
      name = volunteer["name"]
      project_id = volunteer["project_id"].to_i
      volunteers.push(Volunteer.new({id: id, name: name, project_id: project_id}))
    end
    volunteers
  end

  def self.find_by_project(proj_id)
    volunteers = []
    project_volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{proj_id};")
    project_volunteers.each do |volunteer|
      id = volunteer["id"]
      name = volunteer["name"]
      volunteers.push(Volunteer.new({id: id, name: name, project_id: proj_id}))
    end
    volunteers
  end

end