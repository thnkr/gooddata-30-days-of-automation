# 30 Days of Automation: GoodData Ruby SDK
# Visit http://sdk.gooddata.com/gooddata-ruby/ for Tutorials, Examples, and Support.

require 'net/smtp'

email = "CHANGE_TO_YOUR_EMAIL@gooddata.com"

# Leave all of this below alone.
message = <<EOF
From: GOODDATA_PROCESS <gooddatatestemail@gmail.com>
To: RECEIVER <#{email}>
Subject: Hello from your GoodData project. :)
Hope you are having a wonderful weekend. This week is going to be great! Love, the Ruby SDK.
EOF

smtp = Net::SMTP.new 'smtp.gmail.com', 587
smtp.enable_starttls
smtp.start('gmail.com', 'gooddatatestemail@gmail.com', 'testemail1', :login)
smtp.send_message message, email, email
smtp.finish