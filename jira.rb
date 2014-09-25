# encoding=UTF-8
# 30 Days of Automation: GoodData Ruby SDK
# Visit http://sdk.gooddata.com/gooddata-ruby/ for Tutorials, Examples, and Support.

require 'gooddata'

client = GoodData.connect 'USERNAME@gooddata.com', 'PASS'

PROJECT_ID = 'YOUR PROJECT ID'
PROCESS_ID = 'YOUR PROCESS ID' # The ID of the process you want to monitor.
URL = "REPLACE THIS WITH YOUR ZAPIER WEB HOOK"
REMIND_ME_UNTIL = '2014-08-26' # YEAR-MONTH-DAY

# Check on status of a process.
def check_status
  pp process = GoodData.get("/gdc/projects/#{PROJECT_ID}/dataload/processes/#{PROCESS_ID}/executions").to_hash
  meta = process['executions']['items'][0]['executionDetail']
  status = meta['status']
  log = meta['links']['log']

  if status == "ERROR"
  	payload = { 'process_executable' => log, 'process_id' => PROCESS_ID, 'message' => 'A critical process failed.'}
  	RestClient.post URL, payload.to_json, :content_type => :json, :accept => :json

  end


end

# Check on the processes until date defined.
date = Date.parse(REMIND_ME_UNTIL)
if REMIND_ME_UNTIL
	check_status unless date < Date.today
else
	# If remind_me_until is set to "false", check on the status indefinately.
	check_status
end







