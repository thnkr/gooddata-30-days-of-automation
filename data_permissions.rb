# 30 Days of Automation: GoodData Ruby SDK
# Visit http://sdk.gooddata.com/gooddata-ruby/ for Tutorials, Examples, and Support.

require 'gooddata'

client = GoodData.connect 'YOUR_USER_EMAIL@gooddata.com', 'YOUR_PASSWORD'
project = client.projects('PROJECT_ID')

# The CSV (RAW)
csv = "login,department\npaul@company.com,sales\n"

filters = GoodData::UserFilterBuilder::get_filters(csv, {
    :type => :filter,
    :labels => [
        {:label => {:uri => "ATTRIBUTE_LABEL_URI"}, :column => 'department'}
    ]
})

filter = GoodData::UserFilterBuilder.execute_mufs(filters, :dry_run => true)

