# frozen_string_literal: true

module PostsHelper
  def parsing_img(text:)
    nodes = Nokogiri::HTML.parse(text)
    if nodes.xpath('//img').blank?
      Image.find_by(hint: 'default').file.url
    else
      nodes.xpath('//img').attribute('src').value
    end
  end

  def display_day_published(post:)
    if post.published_at.present?
      post.published_at.strftime('%Y %-b %-d')
    else
      'Not published yet.'
    end
  end
end
