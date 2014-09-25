# 30 Days of Automation: GoodData Ruby SDK
# Visit http://sdk.gooddata.com/gooddata-ruby/ for Tutorials, Examples, and Support.

#I am a comment!
require 'gooddata'

# Login to the GoodData project
client = GoodData.connect 'expert.services@gooddata.com', 'asecretpassword'

puts 'Paste the Project ID:'
id = gets.chomp

# Tell the GoodData Module what the default project is.
project = client.projects(id)

CSV.open(id + "_metrics.csv", 'wb') do |csv|
  metrics = project.metrics :full => true
  metrics.each do |metric|
    m = metric.pretty_expression
    puts m
    csv << [m]
  end
end

puts 'The CSV is ready!'
