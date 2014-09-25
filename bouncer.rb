# encoding: UTF-8
# 30 Days of Automation: GoodData Ruby SDK
# Visit http://sdk.gooddata.com/gooddata-ruby/ for Tutorials, Examples, and Support.

require 'gooddata'
require 'pp'
require 'pry'

user = 'YOUR-USERNAME@gooddata.com'
pass = 'YOUR-PASSWORD'
project_id = 'YOUR-PROJECT-ID'

client = GoodData.connect user, pass
project = client.projects(project_id)


reports = project.reports :full => true
white_list = Array.new # Stores the object uri's used in reports.
fact_warnings = Array.new
metric_warnings = Array.new
attribute_warnings = Array.new

reports.each { |report|
  report.using.each do |obj|
  	white_list << obj['link']
  end
}

# Iterate through Facts
puts "Checking Facts...\r"
facts = project.facts.each do |fct|
  obj = { 'link' => fct['link'], 'title' => fct['title'] }
  fact_warnings << obj unless white_list.include? fct['link']
end

# Iterate through Metrics
puts "Checking Metrics...\r"
metrics = project.metrics.each do |metr|
  obj = { 'link' => metr['link'], 'title' => metr['title'] }
  metric_warnings << obj unless white_list.include? metr['link']
end

# Iterate through Attributes
puts 'Checking Attributes...'
attributes = project.attributes.each do |attr|
  obj = { 'link' => attr['link'], 'title' => attr['title'] }

  # Skip Dates to avoid reference errors.
  if attr['tags'].include? 'date'
  	next
  end
  attribute_warnings << obj unless white_list.include? attr['link']
end

puts "\nUNUSED OBJECTS\n"
if metric_warnings.empty? || attribute_warnings.empty? || fact_warnings.empty?
  puts "\n  No suggestions for this project. Great work!\n"
else
  puts "  #{attribute_warnings.length} Attributes"
  puts "  #{fact_warnings.length} Facts"
  puts "  #{metric_warnings.length} Metrics"
  puts "\nWould you like to remove these from the project #{project_id}: (y/n)"
  confirm = gets.chomp
  if confirm == 'YES' || confirm == 'y' || confirm == ''
    puts 'Trimming...'
    dump = (attribute_warnings << metric_warnings << fact_warnings).flatten!
    dump.each do |attr|
      GoodData.delete(attr['link'])
    end
  else
  	exit
  end
end

# datasets = GoodData::Project[project_id].blueprint.datasets
