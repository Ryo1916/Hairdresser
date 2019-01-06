module ApplicationHelper
  # ページごとの完全なタイトルを返します。
  def full_title(page_title = '') # 引数のdefault値を空に設定している
    base_title = "Hairdresser's Website"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
