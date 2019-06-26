# frozen_string_literal: true

SitemapGenerator::Sitemap.default_host = 'https://hairdresser-yuta.herokuapp.com'

SitemapGenerator::Sitemap.create do
  { en: :english, ja: :japanese }.each do |locale, name|
    group(sitemaps_path: "sitemaps/#{locale}/", filename: name) do
      add root_path(locale: locale), changefreq: 'daily'
      add posts_path(locale: locale), changefreq: 'daily'

      Post.published.each do |p|
        add post_path(locale: locale, id: p.friendly_id), lastmod: p.updated_at, changefreq: 'daily'
      end
    end
  end
end

SitemapGenerator::Sitemap.create_index = true

if Rails.env.production?
  SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(
    fog_provider: 'AWS',
    aws_access_key_id: Rails.application.secrets.access_key_id,
    aws_secret_access_key: Rails.application.secrets.secret_access_key,
    fog_directory: Rails.application.secrets.bucket,
    fog_region: Rails.application.secrets.region
  )
  SitemapGenerator::Sitemap.public_path = 'tmp/'
  SitemapGenerator::Sitemap.sitemaps_host = "https://s3-#{Rails.application.secrets.region}.amazonaws.com/#{Rails.application.secrets.bucket}"
  SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
end
