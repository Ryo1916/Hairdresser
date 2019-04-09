# frozen_string_literal: true

module ApplicationHelper
  # Constants
  APP_NAME = 'Hairdresser Yuta'

  # Return web page title
  def full_title(page_title = '')
    base_title = APP_NAME
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end
end
