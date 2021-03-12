require "capybara/rspec"
require "./app"
require "pry"
require('spec_helper')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe 'the project creation path', {:type => :feature} do
  it 'takes the user to the homepage where they can create a project' do
    visit '/'
    fill_in('title', :with => 'Teaching Kids to Code')
    click_button('Create Project')
    expect(page).to have_content('Teaching Kids to Code')
  end
end

describe 'the project details path', {:type => :feature } do
  it 'takes a user to a page for a specific project' do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    visit '/'
    click_link('Teaching Kids to Code')
    expect(page).to have_content('Project Title: Teaching Kids to Code')
  end
end

describe 'the project update path', {:type => :feature} do
  it 'allows a user to change the name of the project' do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    visit '/'
    click_link('Teaching Kids to Code')
    click_link('Edit Project')
    fill_in('title', :with => 'Teaching Ruby to Kids')
    click_button('Update Project')
    expect(page).to have_content('Teaching Ruby to Kids')
  end
end

describe 'the project delete path', {:type => :feature} do
  it 'allows a user to delete a project' do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    id = test_project.id
    visit "/projects/#{id}/edit"
    click_button('Delete Project')
    visit '/'
    expect(page).not_to have_content("Teaching Kids to Code")
  end
end

describe 'the volunteer creation path', {:type => :feature} do
  it 'allows a user to add a volunteer to a project' do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    id = test_project.id
    visit "/projects/#{id}"
    fill_in('volunteer', :with => 'Jane Doe')
    click_button('Add Volunteer')
    expect(page).to have_content('Jane Doe')
  end
end

# # The user should be able to click on a project detail page and see a list of all volunteers working on that project. The user should be able to click on a volunteer to see the volunteer's detail page.

# describe 'the volunteer detail page path', {:type => :feature} do
#   it 'shows a volunteer detail page' do
#     test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
#     test_project.save
#     project_id = test_project.id.to_i
#     test_volunteer = Volunteer.new({:name => 'Jasmine', :project_id => project_id, :id => nil})
#     test_volunteer.save
#     visit "/projects/#{project_id}"
#     click_link('Jasmine')
#     fill_in('name', :with => 'Jane')
#     click_button('Update Volunteer')
#     expect(page).to have_content('Jane')
#   end
# end