require 'aws-sdk'
require 'rubygems'
require 'yaml'
require 'logger'

class Walrus

  def initialize options = {}
    @s3_endpoint = options[:s3_endpoint]
    @s3_port = options[:s3_port]
    @s3_service_path = options[:s3_service_path]
    @access_key_id = options[:access_key_id]
    @secret_access_key = options[:secret_access_key]
    @use_ssl = options[:use_ssl]
    @s3_force_path_style = options[:s3_force_path_style]
    @logging  = options[:logging]

    if @logging
      # TODO:
    end

    # Prepare
    AWS.config({
      :access_key_id => @access_key_id,
      :secret_access_key => @secret_access_key,
      :s3_endpoint => @s3_endpoint,
      :s3_port => @s3_port,
      :s3_service_path => @s3_service_path,
      :s3_force_path_style => @s3_force_path_style,
      :use_ssl => @use_ssl,
      :logger => Logger.new($stdout),
      :log_level => :debug,
      :log_formatter => AWS::Core::LogFormatter.colored,
      :http_wire_trace => true,
    })

    # Create
    @s3 = AWS::S3.new
  end

  # S3 object
  attr_reader :s3

  # [String] Default to s3.amazonaws.com
  attr_reader :s3_endpoint

  # [Integer] Defaults to 443 for S3 for Walrus 8773
  attr_reader :s3_port

  # [String] Defaults to '/' that is S3
  attr_reader :s3_service_path

  # [String] Access key
  attr_reader :access_key_id

  # [String] Secret key
  attr_reader :secret_access_key

  # [Boolean] Default is True, use HTTPS  
  attr_reader :use_ssl

  # [Boolean] Default is False, use True for Walrus
  attr_reader :s3_force_path_style

  # [Boolean] Default is False
  attr_reader :logging

  def create_bucket(bucket_name)
    # Create the bucket
    begin
      if check_bucket(bucket_name)
        raise "Bucket already exists"
      else
        bucket = s3.buckets.create(bucket_name)
      end
    rescue => e
      puts e.message
      puts e.backtrace
      return false
    end
    return true
  end

  def delete_bucket(bucket_name)
    # Delete the bucket
    begin
      if check_bucket(bucket_name)
      	bucket = s3.buckets[bucket_name] # makes no request
        bucket.delete!
      else
      	raise "Bucket does not exists"
      end
    rescue => e
      puts e.message
      puts e.backtrace
      return false
    end
    return true
  end

  def upload_file(bucket_name, key, filename_with_path)
    # Upload file to a bucket
    begin
      if check_bucket(bucket_name)
        if check_object(bucket_name, key)
          raise "Object already exists"
        else
          bucket = s3.buckets[bucket_name]
          object = bucket.objects.create(key, filename_with_path)
          object.write(:file => filename_with_path)
        end
      else
      	raise "Bucket does not exists"
      end
    rescue => e
    	puts e.message
    	puts e.backtrace
    	return false
    end
    return true
  end

  def check_object(bucket_name, key)
    # Check if the object exists or not
    begin
      object = s3.buckets[bucket_name].objects[key] # makes no request
      if object.exists?
        return true
      end
    rescue => e
      puts e.message
      puts e.backtrace
    end
    return false
  end

  def check_bucket(bucket_name)
    # Check if bucket exists
    begin
      bucket = s3.buckets[bucket_name] # makes no request
      if bucket.exists?
        return true
      end
    rescue => e
      puts e.message
      puts e.backtrace
    end
    return false
  end

  def delete_object(bucket_name, key)
    # Delete the object
    begin
      if check_object(bucket_name, key)
      	object = s3.buckets[bucket_name].objects[key]
        object.delete
        return true
      end
    rescue => e
      puts e.message
      puts e.backtrace
    end
    return false
  end

  def list_all_objects(bucket_name)
    begin
      if check_bucket(bucket_name)
      	bucket = s3.buckets[bucket_name] 
        bucket.objects.each do |object|
          puts object.key
        end
      end
    rescue => e
      puts e.message
      puts e.backtrace
    end
  end

  def download_file(bucket_name, key, filename_with_path)
    begin
      if check_object(bucket_name, key)
        object = s3.buckets[bucket_name].objects[key]
        File.open(filename_with_path, 'w') do |file|
          object.read do |chunk|
            file.write(chunk)
          end
        end
        return true
      end
    rescue => e
      puts e.message
      puts e.backtrace
    end
    return false
  end

  def list_all_buckets()
    #List all the buckets in this account
    begin
      s3.buckets.each do |bucket|
        puts bucket.name
      end
    rescue => e
      puts e.message
      puts e.backtrace
    end
  end

end
