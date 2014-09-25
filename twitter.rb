# 30 Days of Automation: GoodData Ruby SDK
# Visit http://sdk.gooddata.com/gooddata-ruby/ for Tutorials, Examples, and Support.

require 'gooddata'
require 'twitter'

client = GoodData.connect 'YOUR_USERNAME@gooddata.com','YOUR_PASSWORD'
project = client.projects('YOUR_PROJECT_ID')

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "VEgE1KQPnOwVF802NfzXmmEaj"
  config.consumer_secret     = "9iXxvNBKXj2RToYB4Bl0SZhughRQKMQ7UQP7MHb5aExPrnDZQX"
  config.access_token        = "2745611036-sOMuAzD3rZqfyWKmxhHuqxHFMxm00uXBrvLhA73"
  config.access_token_secret = "5kqGFwNXxhDUMHymGkw8wUpP9gZrK41n5QtEUvrhfxRiY"
end

# Here we would check a given metric and execute. For the example we will just declare it.
# m = GoodData::Metric[294]
# sales = m.execute
goal = 100
sales = [*1..100].sample + 100

if goal <= sales
  client.update("This quarter our project \"#{project.title}\" made our goal of #{goal} with #{sales}!")
end


