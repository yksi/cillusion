require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'http://cillusion.net'
SitemapGenerator::Sitemap.create do
  add '/browse/users', :changefreq => 'daily', :priority => 0.9
  add '/browse/articles', :changefreq => 'daily', :priority => 0.9
  add '/browse/groups', :changefreq => 'daily', :priority => 0.9
  add '/users/', :changefreq => 'daily', :priority => 0.9
  add '/groups', :changefreq => 'daily', :priority => 0.9
  add '/articles', :changefreq => 'daily', :priority => 0.9

end
SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks