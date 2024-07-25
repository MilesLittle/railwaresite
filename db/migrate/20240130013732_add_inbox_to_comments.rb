class AddInboxToComments < ActiveRecord::Migration[7.1]
  def change
    add_reference :comments, :inbox, null: true, foreign_key: true
  end
end
