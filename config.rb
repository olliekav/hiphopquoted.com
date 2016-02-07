# Typekit domains
# 0.0.0.0, *.hiphopquoted.dev, *.hiphopquoted.com

###
# Helpers
###

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload, host: "hiphopquoted.dev", apply_js_live: true, apply_css_live: true
end

# Ignore the sitemap layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false
page "/404.html", layout: false

# Methods defined in the helpers block are available in templates
helpers do
  def wrap_text(text, include_span)
    if include_span == true
      '<span>' + text + '</span>'
    else
      text
    end
  end
  def page_title
    if current_page.data.title
      "#{current_page.data.title} - Hip Hop Quoted"
    else
      "Hip Hop Quoted - Hip Hop Quotes brought to life with Typography"
    end
  end
  # Set the page description
  def page_description
    if content_for?(:description)
      "#{yield_content(:description)}"
    else
      "A typography experiment based on Hip-Hop Quotes using forward thinking web font experiments and art direction."
    end
  end
  def content_page?
    content_pages = ["index.html", "about.html", "prints.html", "404.html", "500.html"]
    content_pages.include?(current_page.path)
  end
end

activate :directory_indexes

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

  activate :gzip

  # Fix bug with build errors and typography fonts
  ignore 'fonts/*'

  after_build do |builder|
    print "After_build fixes... "
    FileUtils.cp_r(Dir['source/fonts/'],'build/')
    puts "done."
  end

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end