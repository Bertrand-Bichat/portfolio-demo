# Put links creation logic here.
#
# The root path '/' and sitemap index file are added automatically for you.
# Links are added to the Sitemap in the order they are specified.
#
# Usage: add(path, options={})
#        (default options are used if you don't specify)
#
# Defaults: :priority => 0.5, :changefreq => 'weekly',
#           :lastmod => Time.now, :host => default_host
#
# Examples:
#
# Add '/articles'
#
#   add articles_path, :priority => 0.7, :changefreq => 'daily'
#
# Add all articles:
#
#   Article.find_each do |article|
#     add article_path(article), :lastmod => article.updated_at
#   end

# rails sitemap:refresh:no_ping (to refresh sitemap manually without sending info to bots)
# rails sitemap:refresh (to refresh sitemap manually with sending info to bots)


# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.example.com"

# Create a sitemap index
# SitemapGenerator::Sitemap.create_index = true

# Add public links to the sitemap
SitemapGenerator::Sitemap.create(compress: false) do

  # static pages
  # add contact_path
  # add legals_path
  # add cgv_path
  # add about_path

  #index
  # add users_path

  #show
  # User.with_role(:customer).find_each do |u|
  #   add user_path(u.slug), :lastmod => u.updated_at
  # end
end
# rails sitemap:refresh:no_ping (to refresh sitemap manually without sending info to bots)
