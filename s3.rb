# encoding: UTF-8
# 30 Days of Automation: GoodData Ruby SDK
# Visit http://sdk.gooddata.com/gooddata-ruby/ for Tutorials, Examples, and Support.

require 'gooddata'
require 's3'
require 'dropbox_sdk'

GOODDATA_USER = 'USERNAME@gooddata.com'
GOODDATA_PASSWORD = 'PASSWORD'
DROPBOX_TOKEN = 'YOUR DROPBOX TOKEN'
S3_ACCESS_KEY = 'S3 ACCESS KEY'
S3_ACCESS_SECRET = 'S3 ACCESS SECRET'
PROJECT_ID = 'YOUR PROJECT ID'

##############
# STEP 1: S3 #
##############

s3 = S3::Service.new(:access_key_id => S3_ACCESS_KEY, :secret_access_key => S3_ACCESS_SECRET)

# Create a bucket on S3 called "30daysautomation"
puts "Creating S3 bucket..."
n = s3.buckets.build("30daysautomation")
n.save(:location => :us)

# Change context to the appropriate bucket.
bucket = s3.buckets.find("30daysautomation")

# Open the file as a bucket object.
object = bucket.objects.build('start.txt')

# Load the local file into the object.
puts "Uploading to S3..."
object.content = open('start.txt')

object.save

puts "Downloading from S3..."
download = bucket.objects.find("start.txt")

# Download the file and create a version with S3
File.open('s3.txt', 'wb') do |file|
  file << download.content
end

###################
# STEP 2: DROPBOX #
###################

client = DropboxClient.new(DROPBOX_TOKEN)

file = open('s3.txt')
# Upload the file we downloaded from S3 to Dropbox
puts "Uploading to Dropbox..."
upload = client.put_file('s3.txt', file)
puts "uploaded:", upload.inspect

# Write the file we download from Dropbox
puts "Downloading from Dropbox..."
contents, metadata = client.get_file_and_metadata('s3.txt')
open('s3-dropbox.txt', 'w') {|f| f.puts contents }

##################
# STEP 3: WEBDAV #
##################

# Upload the document to WebDAV
client = GoodData.connect GOODDATA_USER, GOODDATA_PASSWORD
project = client.projects(PROJECT_ID)

puts "Uploading to GoodData..."
GoodData.upload_to_project_webdav('s3-dropbox.txt', :directory => '30_days_automation')

url = GoodData.get_project_webdav_path('s3-dropbox.txt').request_uri
puts "Your file is not available at: \nhttps://secure-di.gooddata.com#{url}30_days_automation/s3-dropbox.txt"