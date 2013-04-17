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
      bucket = s3.buckets.create(bucket_name)
    rescue => e
      puts e.message
      puts e.backtrace
    end
  end

  def delete_bucket(bucket_name)

  end

  def upload_file(bucket_name, filename)

  end

  def check_bucket(bucket_name)

  end

  def delete_object(bucket_name, key)

  end

  def download_file(bucket_name, key)

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
