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


end