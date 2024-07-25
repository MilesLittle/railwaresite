class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.references :category, null: false, foreign_key: true
      t.json :title
      t.jsonb :content

      t.timestamps
    end
  end
end
