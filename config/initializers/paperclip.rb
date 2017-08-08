if Rails.env.production?
  Paperclip::Attachment.default_options[:storage]      = :s3
  Paperclip::Attachment.default_options[:s3_host_name] = "s3-#{ENV.fetch('AWS_REGION')}.amazonaws.com"
  Paperclip::Attachment.default_options[:bucket]       = ENV['S3_BUCKET_NAME']
  Paperclip::Attachment.default_options[:s3_region]    = ENV['AWS_REGION']
end
