class AddDescriptionAndCoverImageToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :description, :text
    add_column :posts, :cover_image, :string
  end
end
