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

end