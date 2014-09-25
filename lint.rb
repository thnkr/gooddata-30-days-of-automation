# encoding: UTF-8
# 30 Days of Automation: GoodData Ruby SDK
# Visit http://sdk.gooddata.com/gooddata-ruby/ for Tutorials, Examples, and Support.

require 'gooddata'
require 'pp'

client = GoodData.connect 'YOUR_USERNAME@gooddata.com','YOUR_PASSWORD'
puts 'Enter Project ID for LINT:'
project = client.projects(gets.chomp)
puts "Running LINT on \"#{GoodData.project.title}\"..."
errors = project.blueprint.lint
if errors.length > 0
  pp errors
else
  puts 'No errors! The project is ready to go.'
end
