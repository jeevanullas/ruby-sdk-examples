ruby-sdk-examples
=================

Please read these instructions before running the driver code on your system

## AWS Ruby SDK testcases

### Walrus/S3

In order to run the test case for Walrus, against S3, following needs to be set in driver.rb

```
conn = Walrus.new({
        :s3_endpoint => 's3.amazonaws.com',
        :s3_port => 443,
        :s3_service_path => '/',
        :use_ssl => true,	
        :s3_force_path_style => false,
        :access_key_id => '<Access Key ID>',
        :secret_access_key => '<Secret Key>',
      })
```

Following variables need to be set before you execute the test case for Walrus

```
bucket_name = '<bucket name you want to create>'
file_to_upload = '<file name with path you want to upload to the new bucket>'
file_to_download = '<file to receive the download>'
key = '<key name>'
```



