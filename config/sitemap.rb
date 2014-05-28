SitemapGenerator::Sitemap.default_host = 'http://cillusion.net'
SitemapGenerator::Sitemap.create do
  add root_path
  Article.find_each do |article|
    add article_path(article), :changefreq => 'daily'
  end

  User.find_each do |user|
    add user_path(user), :changefreq => 'daily'
  end

  Group.find_each do |group|
    add group_path(group), :changefreq => 'daily'
  end

  add browse_users_path
  add browse_articles_path
  add browse_groups_path

end