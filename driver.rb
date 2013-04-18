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

# Set some stuff
bucket_name = '<bucket name>'
file_to_upload = '<file to upload>'
file_to_download = '<file to receive the download>'
key = '<key name>'

# Creating a bucket
if conn.create_bucket(bucket_name)
  #Check the bucket got created
  print "Bucket ", bucket_name, " got created successfully\n"
else
  print "Bucket ", bucket_name, " failed to get created\n"
end

print "List all buckets on the cloud\n"
# List all buckets
conn.list_all_buckets()

# Upload a file on the new bucket
if conn.upload_file(bucket_name, key, file_to_upload)
  print "Uploaded file ", file_to_upload, " to bucket ", bucket_name, " successfully\n"
else
  print "Failed to upload ", file_to_upload, " \n"
end

print "List all keys\n"
# List all keys in a bucket - before
conn.list_all_objects(bucket_name)

# Download a file
if conn.download_file(bucket_name, key, file_to_download)
  print "Successfully downloaded file to ", file_to_download , "\n"
end

# Delete the object
if conn.delete_object(bucket_name, key)
  print "Object successfully deleted\n"
end

print "List all keys"
# List all keys in a bucket - after
conn.list_all_objects(bucket_name)

# Delete the bucket
if conn.delete_bucket(bucket_name)
  puts "Bucket successfully deleted\n"
end

print "List all buckets on the cloud\n"
# List all buckets
conn.list_all_buckets()