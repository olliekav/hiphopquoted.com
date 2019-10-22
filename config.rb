# Typekit domains
# 0.0.0.0, *.hiphopquoted.dev, *.hiphopquoted.com

###
# Helpers
###

# Reload the browser automatically whenever files change
# configure :development do
#   activate :livereload, apply_js_live: true, apply_css_live: true
# end

activate :external_pipeline,
         name: :webpack,
         command: build? ? 'npm run build' : 'npm run start',
         source: ".tmp/dist",
         latency: 1

# Ignore the sitemap layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# Methods defined in the helpers block are available in templates
helpers do
  def wrap_text(text, include_span, fit)
    if include_span == true && fit == true
      '<span class="fit">' + text + '</span>'
    elsif include_span == true
      '<span>' + text + '</span>'
    else
      text
    end
  end
  def page_title
    if current_page.data.title
      "#{current_page.data.title} - Hip-Hop Quoted"
    else
      "Hip-Hop Quoted - Hip-Hop Quotes brought to life with Typography"
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
  # def quote_pages
  #   sitemap.resources.find_all {|p| p.source_file.match(/\.html/) && !p.path.match(/about/) && !p.path.match(/404/) && !p.path.match(/500/) && !p.path.match(/prints/) && !p.path.match(/index/)}.sort_by {|p| p.data.order.to_i}.reverse!
  # end
  def quote_pages
    sitemap.resources.select do |resource|
      resource.data.order
    end.sort_by {|resource| resource.data.order.to_i}.reverse!
  end
end

activate :directory_indexes

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

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