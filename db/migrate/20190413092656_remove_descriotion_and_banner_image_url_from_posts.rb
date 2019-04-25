class RemoveDescriotionAndBannerImageUrlFromPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :description, :string
    remove_column :posts, :banner_image_url, :string
  end
end
