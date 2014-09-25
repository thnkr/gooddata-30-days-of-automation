# encoding=UTF-8
# 30 Days of Automation: GoodData Ruby SDK
# Visit http://sdk.gooddata.com/gooddata-ruby/ for Tutorials, Examples, and Support.

require 'gooddata'

client = GoodData.connect 'YOUR_USERNAME@gooddata.com', 'YOUR_PASSWORD'
project = client.projects('PROJECT_ID')

CSV.foreach('users.csv') do |user|
  email = user[0]
  role = user[1]
  project.invite(email, role)
end