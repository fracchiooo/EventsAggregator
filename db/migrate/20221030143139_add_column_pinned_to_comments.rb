class AddColumnPinnedToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :pinned, :boolean, default: false
  end
end
