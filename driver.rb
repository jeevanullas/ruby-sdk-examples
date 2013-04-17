require_relative 'walrus'

conn = Walrus.new({
		:s3_endpoint => '192.168.51.81',
		:s3_port => 8773,
		:s3_service_path => '/services/Walrus/',
	 	:use_ssl => false,	
		:s3_force_path_style => true,
		:access_key_id => 'FVWHLUWNNXGFXSVSOTXTT',
		:secret_access_key => 'Kk7hkLB7tZBMXy00k7SOWXbT7Lo0ZTJ60MMhvf5x',
	   })

# Creating a bucket
conn.create_bucket('mybucket')

# List all buckets
conn.list_all_buckets()
