class CreatePostImages < ActiveRecord::Migration[7.1]
  def change
    create_table :post_images do |t|
      t.belongs_to :post,  foreign_key: true

      t.timestamps
    end
  end
end
