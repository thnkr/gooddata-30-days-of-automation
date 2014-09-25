# encoding: utf-8

# 30 Days of Automation: GoodData Ruby SDK
# Visit http://sdk.gooddata.com/gooddata-ruby/ for Tutorials, Examples, and Support.
require 'gooddata'

# Don't forget to add Connect Yammer account.
client = GoodData.connect 'YOUR_USERNAME@gooddata.com', 'YOUR_PASSWORD'
project = client.projects('PROJECT_ID')

url = "REPLACE THIS WITH YOUR ZAPIER WEB HOOK"
payload = { 'project_title' => project.title, 'attribute_count' => project.attributes.length }

RestClient.post url, payload.to_json, :content_type => :json, :accept => :json


