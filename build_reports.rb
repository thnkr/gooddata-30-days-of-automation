# encoding=UTF-8
# 30 Days of Automation: GoodData Ruby SDK
# Visit http://sdk.gooddata.com/gooddata-ruby/ for Tutorials, Examples, and Support.

require 'gooddata'

client = GoodData.connect 'YOUR_USERNAME@gooddata.com','YOUR_PASSWORD'

project = client.projects('YOUR_PROJECT_ID')

# Open the csv 'report.csv'
@sort_metric = nil
CSV.foreach('report.csv', :headers => true) do |row|

  #You can grab the row by the column title.
  report_title = row['Report']
  fact_title = row['Fact']
  metric_type = row['Metric'].to_sym
  sort = row['Sort']

  # If the sort metric hasn't been set, set it.
  if @sort == nil
  	@sort_metric = GoodData::Fact.find_by_title(sort).first.create_metric(:type => :sum)
  	@sort_metric.save
  end

  # Create a metric from the Fact title assigned in the CSV.
  metric = project.facts.find { |f| f.title = fact_title }.create_metric(:type => metric_type)
  metric.save

  # Create a report and save it.
  report = project.create_report(:title => "#{metric_type} #{fact_title} Demo Report", :left => @sort_metric.uri, :top => metric.uri)
  report.save

end

