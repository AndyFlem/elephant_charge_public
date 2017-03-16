PDFKit.configure do |config|
  config.default_options = {
      :page_size => 'A4',
      :orientation=> 'Portrait',
      :no_print_media_type => true
  }
  # Use only if your external hostname is unavailable on the server.
  config.root_url = "http://localhost:3001/"

  config.verbose = true
end