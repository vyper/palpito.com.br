if Rails.env.production?
  Rails.application.config.paperclip_defaults = {
    storage: :s3,
    s3_credentials: {
      bucket: ENV['S3_BUCKET_NAME'],
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      s3_region: ENV['AWS_REGION'],
    }
  }

  Paperclip::Attachment.default_options[:s3_region]    = ENV.fetch('AWS_REGION')
  Paperclip::Attachment.default_options[:url]          = ':s3_domain_url'
  Paperclip::Attachment.default_options[:path]         = '/:class/:attachment/:id_partition/:style/:filename'
  Paperclip::Attachment.default_options[:s3_host_name] = "s3-#{ENV.fetch('AWS_REGION')}.amazonaws.com"
end
