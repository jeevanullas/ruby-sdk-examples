require_relative 'walrus'

conn = Walrus.new({
         :s3_endpoint => '<Walrus IP address>',
         :s3_port => 8773,
         :s3_service_path => '/services/Walrus/',
         :use_ssl => false,	
         :s3_force_path_style => true,
         :access_key_id => '<Access Key ID>',
         :secret_access_key => '<Secret Key>',
       })

# Creating a bucket
conn.create_bucket('mybucket')

# List all buckets
conn.list_all_buckets()
