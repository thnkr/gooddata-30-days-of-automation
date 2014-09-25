# 30 Days of Automation: GoodData Ruby SDK
# Visit http://sdk.gooddata.com/gooddata-ruby/ for Tutorials, Examples, and Support.


require 'gooddata'
require 'levenshtein'
require 'pp'

puts 'STAGE 1: Connecting to GoodData...'
client = GoodData.connect 'YOUR_USERNAME@gooddata.com', 'YOUR_PASSWORD'
new_project = 'YOUR_PROJECT_ID'

#####################
# Do Not Edit Below #
#####################

project = client.projects(new_project)
new_project_title = project.title
new_project_attributes = project.attributes.map { |a| a['title'] }

projects = Hash.new
projects_score = Hash.new
puts 'STAGE 2: Gathering Attributes from all Projects (this can take several minutes)...'
client.projects.each do |project|
  client.projects(project.pid)
  if project.pid != new_project
  	projects[project.pid] = project.attributes.map { |a| a['title'] }
  	projects_score[project.pid] = 0
  end
end

# Go through each of the projects, find the Levenshtein-D score.
@c = 0
puts 'STAGE 3: Comparing Attributes from #{new_project} with all available Attributes...'
new_project_attributes.each do |attr|
  @c += 1
  @attr = attr
  puts "STAGE 3: Analyzing: #{@attr}, #{@c} of #{new_project_attributes.length}"
  projects.each do |pid, project|
  	@pid = pid
  	@project = project
    @project.each do |pa|
    	l = Levenshtein.distance(@attr, pa)
    	projects_score[@pid] += l
    end
  end
end
puts '=============================================='
puts 'COMPLETE: Similar Projects In Descending Order'
puts '=============================================='
puts "Project Analyzed: #{new_project_title}"
puts "Project Id: #{new_project}"
scores = projects_score.sort_by { |project, score| score }
scores.each do |s|
	puts "Score: |#{s[1]}| Project: #{s[0]}"
end