# frozen_string_literal: true

module ApplicationHelper
  # To display category images on top page instantly
  def category_images
    category_images = [
      'https://images.pexels.com/photos/1319460/pexels-photo-1319460.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
      'https://images.pexels.com/photos/1570807/pexels-photo-1570807.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
      'https://images.pexels.com/photos/668196/pexels-photo-668196.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
      'https://images.pexels.com/photos/6171/hairstyle-hair-wedding-bride.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500',
      'https://images.pexels.com/photos/112782/pexels-photo-112782.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
      'https://images.pexels.com/photos/4614/woman-morning-bathrobe-bathroom.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500'
    ]
  end

  def full_title(page_title: '')
    base_title = Constants::APP_NAME
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end
end
