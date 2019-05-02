# frozen_string_literal: true

module PostsHelper
  def parsing_img(text)
    nodes = Nokogiri::HTML.parse(text)
    if nodes.xpath('//img').blank?
      Image.find_by(hint: 'default')
    else
      nodes.xpath('//img').attribute('src').value
    end
  end
end
