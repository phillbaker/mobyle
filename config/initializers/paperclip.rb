Paperclip.configure do |config|
  config.root               = Rails.root # The application root to anchor relative urls (defaults to Dir.pwd)
  config.env                = Rails.env  # Server env support, defaults to ENV['RACK_ENV'] or 'development'
  config.use_dm_validations = false      # Validate attachment sizes and such, defaults to false
  config.processors_path    = 'lib/pc'   # Relative path to look for processors, defaults to 'lib/paperclip_processors'
end