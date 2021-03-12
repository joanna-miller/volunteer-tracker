class Project
  attr_accessor :title
  attr_reader :id

  def initialize(attrs)
    @title = attrs[:title]
    @id = attrs[:id]
  end

  def title 
    @title
  end

  def id 
    @id
  end

  def self.all
    all_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    all_projects.each() do |project|
      title = project["title"]
      id = project["id"].to_i
      projects.push(Project.new({title: title, id: id}))
    end
    projects
  end

  def ==(project_to_compare)
    self.title == project_to_compare.title
  end

  def save
    result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first["id"].to_i
  end

  def self.find(id)
    project = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
    if project
      title = project["title"]
      id = project["id"]
      Project.new({title: title, id: id})      
    else
      nil
    end
  end

end