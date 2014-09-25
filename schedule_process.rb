# 30 Days of Automation: GoodData Ruby SDK
# Visit http://sdk.gooddata.com/gooddata-ruby/ for Tutorials, Examples, and Support.

require 'gooddata'
require 'pp'

# Change these to be the Project id and the Process id of the script
project_id = 'PROJECT_ID'
process_id = 'PROCESS_ID'

# The Cron schedule to run on this Sunday. Don't worry we will show you how to remove it.
date = '5 8 * * 0'
executable = "schedule_email.rb"

client = GoodData.connect 'YOUR_GOODDATA_EMAIL', 'YOUR_PASSWORD'
project = client.projects(project_id)
process = project.processes(process_id)
schedule = process.create_schedule(date, process.executables.first)
