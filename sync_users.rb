#encoding=UTF-8
# 30 Days of Automation: GoodData Ruby SDK
# Visit http://sdk.gooddata.com/gooddata-ruby/ for Tutorials, Examples, and Support.

require 'gooddata'

client = GoodData.connect 'YOUR_EMAIL@gooddata.com', 'YOUR_PASSWORD'

project = client.projects('PROJECT_ID')

CSV.foreach('users.csv', 'r') do |row|
  email = row[0]
  role = row[1]
  user = project.users.find { |user| user.email == email }
  role = project.roles.find { |role| role.title == role }
  user.role = role
end
