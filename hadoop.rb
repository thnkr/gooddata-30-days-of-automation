# encoding: utf-8

# 30 Days of Automation: GoodData Ruby SDK
# Visit http://sdk.gooddata.com/gooddata-ruby/ for Tutorials, Examples, and Support.

require 's3' # README: https://github.com/qoobaa/s3
require 'gooddata'
require 'mortar-api-sdk'

user = 'YOUR_USERNAME@gooddata.com'
pass = 'YOUR_PASSWORD'
project_id = 'PROJECT ID'
target_dataset = 'DATASET' # Ex. "devs"

client = GoodData.connect user, pass
project = client.projects(project_id)

service = S3::Service.new(:access_key_id => "YOUR_ACCESS_KEY",
	:secret_access_key => "YOUR_SECRET_ACCESS_KEY")

# Change this to the appropriate bucket.
bucket = service.buckets.find("my_test_bucket")

# Change this to the appropriate file.
object = bucket.objects.find("OUTPUT_FILE_HD")

blueprint = GoodData::Project[project_id].blueprint
GoodData::Model.upload_data(object.to_s, blueprint, target_dataset)