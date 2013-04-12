WICKED_PDF = {
  :wkhtmltopdf => (Rails.env.test? || Rails.env.development? ? '/usr/local/bin/wkhtmltopdf' : Rails.root.join('vendor', 'bin', 'wkhtmltopdf-amd64').to_s), #Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s),
  :exe_path => (Rails.env.test? || Rails.env.development? ? '/usr/local/bin/ ' : Rails.root.join('vendor','bin', 'wkhtmltopdf-amd64').to_s)
}