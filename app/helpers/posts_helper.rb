# frozen_string_literal: true

module PostsHelper
  DEFAULT_IMG = 'https://images.pexels.com/photos/1536356/pexels-photo-1536356.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'

  def parsing_img(text)
    nodes = Nokogiri::HTML.parse(text)
    nodes.xpath('//img').blank? ? DEFAULT_IMG : nodes.xpath('//img').attribute('src').value
  end
end
