#encoding: UTF-8
# 30 Days of Automation: GoodData Ruby SDK
# Visit http://sdk.gooddata.com/gooddata-ruby/ for Tutorials, Examples, and Support.
require 'gooddata'

client = GoodData.connect 'YOUR_USERNAME@gooddata.com', 'YOUR_PASSWORD'
project = client.projects('PROJECT_ID')
project.deploy_process('./process.zip', :name => "Testing Process", :type => "RUBY")