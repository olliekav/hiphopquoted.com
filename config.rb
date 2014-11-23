# Typekit domains
# 0.0.0.0, *.hiphopquoted.dev, *.hiphopquoted.com

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
#   config.line_comments = false
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

activate :directory_indexes

# activate :pagination do
#   pageable_resource :quotes do |page|
#     page.data.title.present?
#   end
# end

# Fix bug with build errors and typography fonts
ignore 'fonts/*'

after_build do |builder|
  print "After_build fixes... "
  FileUtils.cp_r(Dir['source/fonts/'],'build/')
  puts "done."
end

# Reload the browser automatically whenever files change
activate :livereload, :host => "hiphopquoted.dev"

# Ignore the sitemap layout
page "/sitemap.xml", :layout => false

# Methods defined in the helpers block are available in templates
helpers do
  def wrap_text(text, include_span)
    if include_span == true
      '<span>' + text + '</span>'
    else
      text
    end
  end
  def store_link?
    false
  end
  def page_title
    if current_page.data.title
      "#{current_page.data.title} - Hip Hop Quoted"
    else
      "Hip Hop Quoted - Hip Hop Quotes brought to life with Typography"
    end
  end
  def content_page?
    current_page.path == "index.html" || current_page.path == "about.html" || current_page.path == "store.html" || current_page.path == "404.html" || current_page.path == "500.html"
  end
end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end