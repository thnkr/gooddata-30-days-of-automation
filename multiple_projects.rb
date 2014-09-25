#encoding: UTF-8
# 30 Days of Automation: GoodData Ruby SDK
# Visit http://sdk.gooddata.com/gooddata-ruby/ for Tutorials, Examples, and Support.

require 'gooddata'

client = GoodData.connect 'YOUR_USERNAME@gooddata.com', 'YOUR_PASSWORD'

projects = [
  'PROJECT_ID_3',
  'PROJECT_ID_2'
]

projects.each do |project|
  proj = client.projects(project)
  pp proj.title
end

