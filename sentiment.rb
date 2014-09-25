# encoding=UTF-8
# This script is intending for use with the scaffold project created from the command 'gooddata scaffold project my_test_project'

require 'gooddata'
require 'sentimental'
require 'csv'

# Sentiment Settings
Sentimental.load_defaults
Sentimental.threshold = 0.1

client = GoodData.connect 'YOUR_USERNAME@gooddata.com', 'YOUR_PASSWORD'
project= client.projects('YOUR_PROJECT_ID')
pid = project.pid

s = Sentimental.new
CSV.open("devs_sentiment.csv", "w") do |csv|
  csv << ["dev_id","email","comment","sentiment", "score"]
  CSV.foreach('devs_comments.csv', :headers => true) do |row|
  	row << s.get_sentiment(row[2])
  	row << s.get_score(row[2])
    csv << row
  end
end

# Update the project model with the comments and sentiment labels you added.
blueprint = eval(File.read('./model/model.rb')).to_blueprint
GoodData::Model.ProjectCreator.migrate(:spec => blueprint, :project => pid)

# Upload your sentiment data!
GoodData::Model.upload_data('devs_sentiment.csv', blueprint, 'devs')
